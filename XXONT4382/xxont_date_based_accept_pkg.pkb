CREATE OR REPLACE PACKAGE BODY xxont_date_based_accept_pkg AS
/***********************************************************************************
** Title:       XX Manual Acceptance for Project Order Lines
** File:        xxont_china_manual_accept_pkg.pkb
** Description: This script creates a package body
** Parameters:  {None}
** Run as:      APPS
** Keyword Tracking:
**
**
** Change History:
**=================================================================================
** Date         | Name              | Remarks
**=================================================================================
**03-jul-2023   | Vimalraj Govindhasamy   | Initial Creation.
************************************************************************************/

    g_sql_stmt VARCHAR2(10);
    g_org_id   NUMBER := fnd_profile.value('ORG_ID');

/* This is the main procedure for this package called from conc program of XXONT2716 */
    PROCEDURE xx_date_based_accept_main (
        p_errbuf         OUT VARCHAR2,
        p_retcode        OUT VARCHAR2,
        p_org_id         IN NUMBER,
        p_so_number      IN NUMBER,
        p_so_line_number IN NUMBER
    ) AS

        l_action_request_tbl       oe_order_pub.request_tbl_type;
        l_expiry_date              DATE := sysdate;
        x_header_out_rec           oe_order_pub.header_rec_type;
        x_header_adj_out_tbl       oe_order_pub.header_adj_tbl_type;
        x_header_price_att_out_tbl oe_order_pub.header_price_att_tbl_type;
        x_header_adj_att_out_tbl   oe_order_pub.header_adj_att_tbl_type;
        x_header_adj_assoc_out_tbl oe_order_pub.header_adj_assoc_tbl_type;
        x_header_scredit_out_tbl   oe_order_pub.header_scredit_tbl_type;
        x_line_out_tbl             oe_order_pub.line_tbl_type;
        x_line_adj_out_tbl         oe_order_pub.line_adj_tbl_type;
        x_line_price_att_out_tbl   oe_order_pub.line_price_att_tbl_type;
        x_line_adj_att_out_tbl     oe_order_pub.line_adj_att_tbl_type;
        x_line_adj_assoc_out_tbl   oe_order_pub.line_adj_assoc_tbl_type;
        x_line_scredit_out_tbl     oe_order_pub.line_scredit_tbl_type;
        x_lot_serial_out_tbl       oe_order_pub.lot_serial_tbl_type;
        x_return_status            VARCHAR2(1);
        x_msg_count                NUMBER;
        x_msg_data                 VARCHAR2(2000);
        l_message                  VARCHAR2(4000);
        l_msg_index_out            NUMBER;
        l_count                    NUMBER := 0;
    BEGIN
        xx_pk_fnd_file.put_line(
                               xx_pk_fnd_file.log,
                               'Report Parameters--'
        );
        xx_pk_fnd_file.put_line(
                               xx_pk_fnd_file.log,
                               'ORG ID:' || p_org_id
        );
        xx_pk_fnd_file.put_line(
                               xx_pk_fnd_file.log,
                               'p_so_number:' || p_so_number
        );
        xx_pk_fnd_file.put_line(
                               xx_pk_fnd_file.log,
                               'p_so_line_number:' || p_so_line_number
        );
        xx_pk_fnd_file.put_line(
                               xx_pk_fnd_file.log,
                               'Opening MAIN CURSOR'
        );
        FOR c IN ( ---query for non-risky orders
            SELECT
                order_number,
                ottl.name            order_type,
                l.line_number
                || '.'
                || l.shipment_number line_number,
                l.line_id,
                l.header_id,
                l.org_id,
                l.item_type_code,
                l.top_model_line_id,
                xohd.global_attribute10, --risky order flag
                xohd.global_attribute12,  ---risky order details
                xold.attribute22,  --risky release flag
                xold.attribute13, --customer acceptance date
                decode(
                    l.item_type_code, 'CONFIG', l.top_model_line_id, 'OPTION', l.top_model_line_id, l.line_id
                )                    line_id_to_progress,
                decode(
                    l.item_type_code, 'CONFIG',(
                        SELECT
                            open_flag
                        FROM
                            oe_order_lines_all
                        WHERE
                            line_id = l.top_model_line_id
                    ), 'OPTION',(
                        SELECT
                            open_flag
                        FROM
                            oe_order_lines_all
                        WHERE
                            line_id = l.top_model_line_id
                    ), l.open_flag
                )                    to_prog_line_open_flag,
                l.open_flag,
                (
                    SELECT
                        COUNT(1)
                    FROM
                        wf_item_activity_statuses wias,
                        wf_process_activities     wpa
                    WHERE
                        wias.item_type = 'OEOL'
                        AND wias.process_activity = wpa.instance_id
                        AND wpa.activity_name = 'XXONT_ACCPT_DEFERL_HOLDS_BLK'
                        AND wias.activity_status = 'NOTIFIED'
                        AND wpa.process_item_type = 'OEOL'
                        AND item_key = to_char(
                            decode(
                                l.item_type_code, 'CONFIG', l.top_model_line_id, 'OPTION', l.top_model_line_id, l.line_id
                            )
                        )
                )                    wf_progress
            FROM
                oe_order_headers_all       h,
                oe_order_lines_all         l,
                oe_transaction_types_tl    ottl,
                xxont_order_header_details xohd,
                xxont_order_line_details   xold,
                hr_operating_units         hou
            WHERE
                1 = 1
                AND h.header_id = l.header_id
                AND h.header_id = xohd.header_id
                AND l.line_id = xold.line_id
                AND h.org_id = hou.organization_id
                AND h.order_type_id = ottl.transaction_type_id
                AND h.org_id = hou.organization_id
                AND ottl.language = userenv(
                    'LANG'
                )
            /*    AND ( ( l.item_type_code = 'STANDARD'
                        AND l.contingency_id IS NOT NULL )
                      OR ( l.item_type_code IN ( 'CONFIG', 'OPTION' )
                           AND (
                    SELECT
                        COUNT(1)
                    FROM
                        oe_order_lines_all lt
                    WHERE
                        lt.line_id = l.top_model_line_id
                        AND lt.contingency_id IS NOT NULL
                ) = 1 ) )*/
           --and l.open_flag = 'Y'-- this condition not req as for Config Items, the line will be closed, but the model line can be open for invoice
                AND l.actual_shipment_date IS NOT NULL  -- Line Need to be Shipped)
                AND h.org_id = g_org_id
                AND xohd.global_attribute10 IN ( 'No', NULL ) -- Non-risky orders
                AND l.flow_status_code = 'SHIPPED'
                AND l.line_id = nvl(
                    p_so_line_number, l.line_id
                )
                AND h.header_id = nvl(
                    p_so_number, h.header_id
                )
		---   AND xold.ATTRIBUTE13 <=  SYSDATE
                AND EXISTS (
                    SELECT
                        1
                    FROM
                        fnd_lookup_values flv
                    WHERE
                        1 = 1
                        AND flv.lookup_type = 'XXONT_DATE_BASED_ACCEPTANCE'
                        AND flv.enabled_flag = 'Y'
                        AND flv.language = 'US'
                        AND meaning = hou.name
                )
                AND EXISTS (
                    SELECT
                        1
                    FROM
                        fnd_lookup_values flv
                    WHERE
                        1 = 1
                        AND flv.lookup_type = 'XXONT4382_ORDER_TYPE'
                        AND flv.enabled_flag = 'Y'
                        AND flv.language = 'US'
                        AND meaning = ottl.name
                )
            UNION
					---query for n9n-risky orders
            SELECT
                order_number,
                ottl.name            order_type,
                l.line_number
                || '.'
                || l.shipment_number line_number,
                l.line_id,
                l.header_id,
                l.org_id,
                l.item_type_code,
                l.top_model_line_id,
                xohd.global_attribute10,
                xohd.global_attribute12,
                xold.attribute22,  --risky release flag
                xold.attribute13, --customer acceptance date
                decode(
                    l.item_type_code, 'CONFIG', l.top_model_line_id, 'OPTION', l.top_model_line_id, l.line_id
                )                    line_id_to_progress,
                decode(
                    l.item_type_code, 'CONFIG',(
                        SELECT
                            open_flag
                        FROM
                            oe_order_lines_all
                        WHERE
                            line_id = l.top_model_line_id
                    ), 'OPTION',(
                        SELECT
                            open_flag
                        FROM
                            oe_order_lines_all
                        WHERE
                            line_id = l.top_model_line_id
                    ), l.open_flag
                )                    to_prog_line_open_flag,
                l.open_flag,
                (
                    SELECT
                        COUNT(1)
                    FROM
                        wf_item_activity_statuses wias,
                        wf_process_activities     wpa
                    WHERE
                        wias.item_type = 'OEOL'
                        AND wias.process_activity = wpa.instance_id
                        AND wpa.activity_name = 'XXONT_ACCPT_DEFERL_HOLDS_BLK'
                        AND wias.activity_status = 'NOTIFIED'
                        AND wpa.process_item_type = 'OEOL'
                        AND item_key = to_char(
                            decode(
                                l.item_type_code, 'CONFIG', l.top_model_line_id, 'OPTION', l.top_model_line_id, l.line_id
                            )
                        )
                )                    wf_progress
            FROM
                oe_order_headers_all       h,
                oe_order_lines_all         l,
                oe_transaction_types_tl    ottl,
                xxont_order_header_details xohd,
                xxont_order_line_details   xold,
                hr_operating_units         hou
            WHERE
                1 = 1
                AND h.header_id = l.header_id
                AND h.header_id = xohd.header_id
                AND l.line_id = xold.line_id
                AND h.org_id = hou.organization_id
                AND h.order_type_id = ottl.transaction_type_id
                AND h.org_id = hou.organization_id
                AND ottl.language = userenv(
                    'LANG'
                )
          /*      AND ( ( l.item_type_code = 'STANDARD'
                        AND l.contingency_id IS NOT NULL )
                      OR ( l.item_type_code IN ( 'CONFIG', 'OPTION' )
                           AND (
                    SELECT
                        COUNT(1)
                    FROM
                        oe_order_lines_all lt
                    WHERE
                        lt.line_id = l.top_model_line_id
                        AND lt.contingency_id IS NOT NULL
                ) = 1 ) ) */
           --and l.open_flag = 'Y'-- this condition not req as for Config Items, the line will be closed, but the model line can be open for invoice
                AND l.actual_shipment_date IS NOT NULL  -- Line Need to be Shipped)
                AND h.org_id = g_org_id
                AND xohd.global_attribute10 = 'Yes' -- Risky order flag
                AND xold.attribute22 = 'Yes' --Release risky order flag
		  -- AND xold.ATTRIBUTE13 <=  SYSDATE
                AND l.flow_status_code = 'SHIPPED'
                AND l.line_id = nvl(
                    p_so_line_number, l.line_id
                )
                AND h.header_id = nvl(
                    p_so_number, h.header_id
                )
                AND EXISTS (
                    SELECT
                        1
                    FROM
                        fnd_lookup_values flv
                    WHERE
                        1 = 1
                        AND flv.lookup_type = 'XXONT_DATE_BASED_ACCEPTANCE'
                        AND flv.enabled_flag = 'Y'
                        AND flv.language = 'US'
                        AND meaning = hou.name
                )
                AND EXISTS (
                    SELECT
                        1
                    FROM
                        fnd_lookup_values flv
                    WHERE
                        1 = 1
                        AND flv.lookup_type = 'XXONT4382_ORDER_TYPE'
                        AND flv.enabled_flag = 'Y'
                        AND flv.language = 'US'
                        AND meaning = ottl.name
                )
        )

		-- End of CR10192 changes
         LOOP

            --mo_global.init ('ONT');
            mo_global.set_policy_context(
                                        'S',
                                        c.org_id
            );
            xx_pk_fnd_file.put_line(
                                   xx_pk_fnd_file.log,
                                   '(+) Processing Details : order_number='
                                   || c.order_number
                                   || ', order_type='
                                   || c.order_type
                                   || ', line_number='
                                   || c.line_number
                                   || ', line_id='
                                   || c.line_id_to_progress
                                   || ', item_type_code='
                                   || c.item_type_code
                                   || ', wf_progress='
                                   || c.wf_progress
            );

            xx_pk_fnd_file.put_line(
                                   xx_pk_fnd_file.output,
                                   '(+) Processing Details : order_number='
                                   || c.order_number
                                   || ', order_type='
                                   || c.order_type
                                   || ', line_number='
                                   || c.line_number
                                   || ', line_id='
                                   || c.line_id_to_progress
                                   || ', item_type_code='
                                   || c.item_type_code
                                   || ', wf_progress='
                                   || c.wf_progress
            );

            l_count := l_count + 1;
            IF c.attribute13 <= sysdate THEN
            ---- this is a ship only workflow
                IF c.wf_progress != 0 THEN
                    BEGIN
                        wf_engine.completeactivity(
                                                  'OEOL',
                                                  c.line_id_to_progress,
                                                  'XXONT_ACCPT_DEFERL_HOLDS_BLK',
                                                  NULL
                        );
                        xx_pk_fnd_file.put_line(
                                               xx_pk_fnd_file.log,
                                               '      (-) : WF Progress: Succcess'
                        );
                    EXCEPTION
                        WHEN OTHERS THEN
                            xx_pk_fnd_file.put_line(
                                                   xx_pk_fnd_file.log,
                                                   '      (-) : WF Progress: Exception - ' || sqlerrm
                            );
                    END;

            --else --- We need to explicitly accept the Line
            --elsif (c.order_type LIKE 'Standard%') AND (c.to_prog_line_open_flag = 'Y') then
                ELSIF
                    ( ( c.order_type LIKE 'Standard%' ) OR ( c.order_type LIKE 'Intercompany%' ) )
                    AND ( c.to_prog_line_open_flag = 'Y' )
                THEN  --Commented above and added condition for Intercompany for DEF#20595(RT#6350330) by Kedar
                --before runing the program, config items will have open_flag = N whereas their madel will have open_flag = Y
                --and standard items will have open_flag = Y and their madel also will have open_flag = Y
                --so added the condition- to_prog_line_open_flag = 'Y'

                --flush out the variables first
                    x_header_adj_out_tbl := oe_order_pub.g_miss_header_adj_tbl;
                    x_header_price_att_out_tbl := oe_order_pub.g_miss_header_price_att_tbl;
                    x_header_adj_att_out_tbl := oe_order_pub.g_miss_header_adj_att_tbl;
                    x_header_adj_assoc_out_tbl := oe_order_pub.g_miss_header_adj_assoc_tbl;
                    x_header_scredit_out_tbl := oe_order_pub.g_miss_header_scredit_tbl;
                    x_line_out_tbl := oe_order_pub.g_miss_line_tbl;
                    x_line_adj_out_tbl := oe_order_pub.g_miss_line_adj_tbl;
                    x_line_price_att_out_tbl := oe_order_pub.g_miss_line_price_att_tbl;
                    x_line_adj_att_out_tbl := oe_order_pub.g_miss_line_adj_att_tbl;
                    x_line_adj_assoc_out_tbl := oe_order_pub.g_miss_line_adj_assoc_tbl;
                    x_line_scredit_out_tbl := oe_order_pub.g_miss_line_scredit_tbl;
                    x_lot_serial_out_tbl := oe_order_pub.g_miss_lot_serial_tbl;
                    l_action_request_tbl := oe_order_pub.g_miss_request_tbl;

                --assign values for l_action_request_tbl
                    l_action_request_tbl(1).entity_code := oe_globals.g_entity_line;
                    l_action_request_tbl(1).request_type := oe_globals.g_accept_fulfillment;
                    l_action_request_tbl(1).entity_id := c.line_id_to_progress;
                    l_action_request_tbl(1).param4 := 'Y';
                    l_action_request_tbl(1).param5 := c.header_id;
                    l_action_request_tbl(1).date_param1 := l_expiry_date;
                    xx_pk_fnd_file.put_line(
                                           xx_pk_fnd_file.log,
                                           '      (-) : Calling OE_Order_PVT.Process_Order for line_id= ' || c.line_id
                    );
                --run the API
                    oe_order_pvt.process_order(
                                              p_api_version_number     => 1.0,
                                              x_return_status          => x_return_status,
                                              x_msg_count              => x_msg_count,
                                              x_msg_data               => x_msg_data,
                                              p_x_header_rec           => x_header_out_rec,
                                              p_x_header_adj_tbl       => x_header_adj_out_tbl,
                                              p_x_header_price_att_tbl => x_header_price_att_out_tbl,
                                              p_x_header_adj_att_tbl   => x_header_adj_att_out_tbl,
                                              p_x_header_adj_assoc_tbl => x_header_adj_assoc_out_tbl,
                                              p_x_header_scredit_tbl   => x_header_scredit_out_tbl,
                                              p_x_line_tbl             => x_line_out_tbl,
                                              p_x_line_adj_tbl         => x_line_adj_out_tbl,
                                              p_x_line_price_att_tbl   => x_line_price_att_out_tbl,
                                              p_x_line_adj_att_tbl     => x_line_adj_att_out_tbl,
                                              p_x_line_adj_assoc_tbl   => x_line_adj_assoc_out_tbl,
                                              p_x_line_scredit_tbl     => x_line_scredit_out_tbl,
                                              p_x_lot_serial_tbl       => x_lot_serial_out_tbl,
                                              p_x_action_request_tbl   => l_action_request_tbl,
                                              p_action_commit          => fnd_api.g_true
                    );

                    xx_pk_fnd_file.put_line(
                                           xx_pk_fnd_file.log,
                                           '      (-) : API OE_Order_PVT.Process_Order completed'
                    );

               -- xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  '      (-) : API Status :' || DECODE(x_return_status,'S', 'Success','E', 'Error','U', 'Unexpected Error',x_return_status));
                    xx_pk_fnd_file.put_line(
                                           xx_pk_fnd_file.log,
                                           '      (-) : API Status :'
                                           || CASE x_return_status
                                               WHEN 'S' THEN
                                                   'Success'
                                               WHEN 'E' THEN
                                                   'Error'
                                               WHEN 'U' THEN
                                                   'Unexpected Error'
                                               ELSE x_return_status
                                           END
                    );

                    IF x_return_status <> fnd_api.g_ret_sts_success THEN
                        oe_msg_pub.initialize;
                        FOR l_msg_count_index IN 1..x_msg_count LOOP
                            IF x_msg_count > 0 THEN
                                oe_msg_pub.get(
                                              p_msg_index     => l_msg_count_index,
                                              p_encoded       => fnd_api.g_false,
                                              p_data          => x_msg_data,
                                              p_msg_index_out => l_msg_index_out
                                );

                                IF l_message IS NULL THEN
                                    l_message := SUBSTR(
                                                       TRANSLATE(
                                                                x_msg_data,
                                                                CHR(10),
                                                                '.'
                                                       ),
                                                       1,
                                                       300
                                                 );

                                ELSE
                                    l_message := l_message
                                                 || ' . '
                                                 || TRANSLATE(
                                                             x_msg_data,
                                                             CHR(10),
                                                             '.'
                                                    );
                                END IF;

                            END IF;
                        END LOOP;

                        xx_pk_fnd_file.put_line(
                                               xx_pk_fnd_file.log,
                                               '      (-) : Error from API :' || l_message
                        );
                    END IF;

                ELSE
                    xx_pk_fnd_file.put_line(
                                           xx_pk_fnd_file.log,
                                           '      (-) : Line is not eligible to progress'
                    );
                    xx_pk_fnd_file.put_line(
                                           xx_pk_fnd_file.output,
                                           '      (-) : Line is not eligible to progress'
                                           || c.order_number
                                           || ',line_number='
                                           || c.line_number
                    );

                END IF;
            ELSE
                xx_pk_fnd_file.put_line(
                                       xx_pk_fnd_file.log,
                                       '      (-) : Line is not eligible to process'
                );
            END IF;

        END LOOP;

        xx_pk_fnd_file.put_line(
                               xx_pk_fnd_file.log,
                               'No of Order Line progressed for the Invoice Acceptance process' || l_count
        );
        IF l_count = 0 THEN
            xx_pk_fnd_file.put_line(
                                   xx_pk_fnd_file.log,
                                   'Order Line not eligible for the Invoice Acceptance progress, please check.'
            );
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            xx_pk_fnd_file.put_line(
                                   xx_pk_fnd_file.log,
                                   'Exception Main : ' || sqlerrm
            );
            p_retcode := 2;
    END xx_date_based_accept_main;

END xxont_date_based_accept_pkg;
/

SHOW ERR