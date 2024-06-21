/*


#ROS Script Version 10.1.2.0.2 - Production

Copyright (c) Oracle Corporation 1992, 2005. All rights reserved.
*/

DESCRIBE  SRW2_DISPLAY_TAG
BEGIN
  UB4       ITEMID
  TEXT      CM_TEXT
  TEXT      CM_FILL
  TEXT      CM_BORD
  SB4       PENWID
  UB4       ADD_FLAGS
  UB2       TEXTPAT
  UB2       TEXTFORE
  UB2       TEXTBACK
  UB2       LINEPAT
  UB2       LINEFORE
  UB2       LINEBACK
  UB2       FILLPAT
  UB2       FILLFORE
  UB2       FILLBACK
  UB2       FONTFACE
  UB2       FONTSIZE
  UB2       FONTSTYLE
  UB2       FONTWEIGHT
  UB2       CHARSET
  UB2       CHARWIDTH
  UB2       BASELINE
  UB2       KERNING
  UB2       DASHSTYLE
  UB2       CAPSTYLE
  UB2       JOINSTYLE
  UB2       BORDSTYLE
  UB1       PERS_FLAGS
  UB4       NULL_FLAGS
END

DESCRIBE  TOOL_COMMENT
BEGIN
  UB4       ITEMID
  UB4       OBJECT_ID
  TLONG     CMTLFID_T
END

DESCRIBE  TOOL_PLSQL
BEGIN
  UB4       ITEMID
  TEXT      NAME
  BLONG     PLSLFID_EP
  UB4       OBJECT_ID
  UB1       TYPE
  TLONG     PLSLFID_ST
  UB4       STATE
END

DESCRIBE  SRW2_ELEMENT
BEGIN
  UB4       ITEMID
  TEXT      ALIAS
  TEXT      EXPR
  TEXT      DESC_EXPR
  UB2       SEL_ORDER
  UB2       DATA_TYPE
  UB4       WIDTH
  SB2       SCALE
  SB2       PRECISION
  UB4       QUERYID
  UB2       ODATA_TYPE
  UB4       RELOPLST
  UB1       PERS_FLAGS
END

DESCRIBE  SRW2_QUERY
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  TLONG     QUERYLFID
  TEXT      NET_LOGON
  TEXT      EXT_QUERY
  TEXT      TEMP_TABLE
  UB1       TEMP_FLAGS
  UB1       EXEC_FREQ
  UB4       MAX_ROWS
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB1       PERS_FLAGS
  UB1       DSTYPE
  TEXT      PLUGINXML
  TEXT      PLUGINCLZ
  UB4       MAJORVER
  UB4       MINORVER
  UB4       SIGNONPRM
  TLONG     PLUGINXMLID
END

DESCRIBE  SRW2_GROUP
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       PTAG
  UB4       QUERY_ID
  UB4       PARENT_ID
  UB1       QLF_TYPE
  SB2       QLF_ARG
  UB4       QLF_COLUMN
  UB1       GLF_TYPE
  SB2       GLF_ARG
  UB4       GLF_COLUMN
  UB1       RLF_TYPE
  SB2       RLF_ARG
  UB4       RLF_COLUMN
  UB1       CROSS_PROD
  UB4       PRODUCT_ID
  UB4       NUM_POINTS
  BINARY    NUM_POINTS:POINTS
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       DFLT_DIR
  UB1       PERS_FLAGS
  TEXT      MAIL_TEXT
  TEXT      XML_TAG
  TEXT      XML_ATTR
  BOOLEAN   XML_SUPPRESS
  TEXT      OUTER_XML_TAG
  TEXT      OUTER_ATTR
END

DESCRIBE  SRW2_COLUMN
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       GROUP_ID
  UB2       SOURCE
  UB4       SOURCE_ID
  UB4       COMPUTE_ID
  TEXT      PROD_ORDER
  UB4       RESET_ID
  TEXT      NULL_VALUE
  TEXT      INPUT_MASK
  UB1       OPERATOR
  UB1       DATA_TYPE
  UB1       FILE_TYPE
  UB4       WIDTH
  UB2       FLAGS
  SB2       PRECISION
  SB2       SCALE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  TEXT      DFLT_LBL
  UB4       DFLT_WID
  UB4       DEREF_ID
  UB2       ODATA_TYPE
  UB4       DFLT_HGT
  UB2       PARA_TYPE
  UB1       PLOV_RTYPE
  UB4       PLOV_SLISTID
  TEXT      PLOV_SELECT
  TEXT      PLOV_COL
  UB1       REFDTYPE
  UB1       PERS_FLAGS
  UB1       EXPANDED
  UB4       SUBGROUP
  TEXT      TYPENAME
  TEXT      SCHEMA
  UB4       PARENT_COL
  UB1       BOUND
  UB4       SORTSRCCOL
  UB4       SORTCOL
  TEXT      XML_TAG
  TEXT      XML_ATTR
  UB1       XML_SUPPRESS
  UB1       CONTAIN_XML
  UB4       RTYPE
  TEXT      PDSCLS
END

DESCRIBE  SRW2_LINK
BEGIN
  UB4       ITEMID
  UB4       TAG
  UB2       DISP_ORDER
  UB4       PARENT_ID
  UB4       P_COLUMN
  UB4       CHILD_ID
  UB4       C_COLUMN
  UB1       CLAUSE
  UB1       OPERATOR
  UB4       NUM_POINTS
  BINARY    NUM_POINTS:POINTS
  UB1       PERS_FLAGS
END

DESCRIBE  SRW2_BOILERPLATE
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  UB1       TYPE
  UB4       NUM_POINTS
  BINARY    NUM_POINTS:POINTS
  UB2       GRAPH_TYPE
  BLONG     GRAPH_LFID
  SB4       GRAPH_LEN
  UB1       CLOSE
  SB2       MIN_WIDOWS
  SB2       MIN_ORPHAN
  SB2       MAX_LINES
  UB1       TEXT_WRAP
  UB1       ALIGNMENT
  UB1       ARCFILL
  UB1       ARROWSTYLE
  SB2       ROTANGLE
  SB4       SPACING
  TEXT      LINKEDFILE
  BLONG     POINTSLFID
  BLONG     OLE_LFID
  SB4       OLE_LEN
  UB4       BIDI_DIR
  UB4       ASSOCOBJ
  UB1       PERS_FLAGS
  UB4       GROUP_NODE
  UB1       GN_TYPE
  UB4       NULL_IND1
  UB4       NULL_IND2
  UB4       NULL_IND3
  UB4       TEMPL_ID
  UB4       FRAME_ID
  TEXT      ALTXT
  TEXT      HEADERS
  UB4       LABFIELD
  TEXT      ACCKEY
END

DESCRIBE  SRW2_TEXT_SEGMENT
BEGIN
  UB4       ITEMID
  UB2       SEG_ORDER
  UB4       TAG
END

DESCRIBE  SRW2_OG_DOCUMENT
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  TEXT      OG_DNAME
  TEXT      OG_QNAME
  UB2       OG_SLOC
  UB4       GROUP_ID
  UB1       PERS_FLAGS
  UB2       OG_DTYPE
  UB4       PLACE_ID
  UB4       GRP_TOP_ID
  UB4       GRP_BOT_ID
  TEXT      OG_LINK
  TEXT      CHART_XMLDEF
  TEXT      ALTXT
  TLONG     XMLDEFID
END

DESCRIBE  SRW2_OGD_COLUMN_MAP
BEGIN
  UB4       ITEMID
  UB4       SRW_COLID
  UB2       OG_COLTYPE
  TEXT      OG_COLNAME
  UB1       PERS_FLAGS
  UB1       OG_COLSUBT
END

DESCRIBE  SRW2_FRAME
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  UB4       GROUP_ID
  UB4       CONTINUED
  UB2       DIRECTION
  SB2       MIN_WIDOWS
  SB2       MIN_ORPHAN
  SB2       MAX_LINES
  SB4       BETWEEN_X
  SB4       BETWEEN_Y
  SB4       RESERVED
  UB4       BIDI_DIR
  SB2       MAX_COLS
  SB2       MAX_ROWS
  UB1       PERS_FLAGS
  UB4       GROUP_NODE
  UB1       GN_TYPE
  UB4       NULL_IND1
  UB4       NULL_IND2
  UB1       FRAME_TYPE
  UB4       TEMPL_ID
  TEXT      TABCAP
END

DESCRIBE  SRW2_MATRIX
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB2       PAGE
  UB4       DOWN_ID
  UB4       ACROSS_ID
  UB4       GROUP_ID
  UB1       PERS_FLAGS
END

DESCRIBE  SRW2_FIELD
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  UB1       PGN_FLAGS
  UB2       PGN_START
  UB2       PGN_INCR
  UB4       PGN_RESET
  UB4       SOURCE_ID
  UB4       CONTINUED
  UB1       ALIGNMENT
  UB1       TEXT_WRAP
  SB2       MIN_WIDOWS
  SB2       MIN_ORPHAN
  SB2       MAX_LINES
  TEXT      MASK
  TEXT      NULL_VALUE
  SB4       SPACING
  UB4       BIDI_DIR
  UB1       PERS_FLAGS
  UB4       GROUP_NODE
  UB1       GN_TYPE
  UB4       NULL_IND1
  UB4       NULL_IND2
  UB4       NULL_IND3
  UB4       TEMPL_ID
  UB4       FRAME_ID
  TEXT      ALTXT
  TEXT      HEADERS
END

DESCRIBE  SRW2_ANCHOR
BEGIN
  UB4       ITEMID
  UB4       TAG
  UB2       DISP_ORDER
  UB4       HEAD_ID
  UB1       HEAD_EDGE
  UB4       HEAD_PCT
  UB4       TAIL_ID
  UB1       TAIL_EDGE
  UB4       TAIL_PCT
  UB4       NUM_POINTS
  BINARY    NUM_POINTS:POINTS
  UB2       COLLAPSE
  UB1       PERS_FLAGS
END

DESCRIBE  SRW2_LAYOUT
BEGIN
  UB4       ITEMID
  UB4       SETTINGS
  SB2       ZOOMPOWER
  UB1       UNITS
  UB1       ORIENT
  SB4       UNITS_WID
  SB4       UNITS_HGT
  SB4       CHAR_WID
  SB4       CHAR_HGT
  SB4       BODY_WID
  SB4       BODY_HGT
  SB4       PAGE_WID
  SB4       PAGE_HGT
  SB4       PRINT_WID
  SB4       PRINT_HGT
  SB4       X_PANELS
  SB4       Y_PANELS
  UB2       HEADERS
  UB2       TRAILERS
  SB4       WINDOW_X
  SB4       WINDOW_Y
  SB4       WINDOW_WD
  SB4       WINDOW_HT
  UB2       RUN_FLAGS
  TEXT      TITLE
  TEXT      HINT
  TEXT      STATUS
  UB2       MAXHEADERS
  UB2       MAXTRAILERS
  UB2       MAXBODY_ACR
  UB2       MAXBODY_DWN
  UB1       INTERN_VER
  UB2       INTERN_VER2
  UB4       APPLSTATE
  UB4       UIFLAGS
  SB4       GRIDINTC
  SB4       GRIDSNPC
  UB1       HALIGN
  UB1       VALIGN
  SB4       RRECTCNR_WD
  SB4       RRECTCNR_HT
  SB4       SPACING
  UB1       JUSTIFIC
  UB1       ARROWSTYLE
  UB4       UITAG
  UB4       NEXTLISTID
  UB4       IDROLESLIST
  UB4       BIDI_DIR
  UB1       PERS_FLAGS
  SB4       HDR_UNITS_WID
  SB4       HDR_UNITS_HGT
  SB4       HDR_CHAR_WID
  SB4       HDR_CHAR_HGT
  SB4       HDR_BODY_WID
  SB4       HDR_BODY_HGT
  SB4       HDR_PAGE_WID
  SB4       HDR_PAGE_HGT
  SB4       HDR_PRINT_WID
  SB4       HDR_PRINT_HGT
  SB4       HDR_X_PANELS
  SB4       HDR_Y_PANELS
  SB4       TRL_UNITS_WID
  SB4       TRL_UNITS_HGT
  SB4       TRL_CHAR_WID
  SB4       TRL_CHAR_HGT
  SB4       TRL_BODY_WID
  SB4       TRL_BODY_HGT
  SB4       TRL_PAGE_WID
  SB4       TRL_PAGE_HGT
  SB4       TRL_PRINT_WID
  SB4       TRL_PRINT_HGT
  SB4       TRL_X_PANELS
  SB4       TRL_Y_PANELS
  UB2       HDR_MAXBODY_ACR
  UB2       HDR_MAXBODY_DWN
  UB2       TRL_MAXBODY_ACR
  UB4       DIST_OVERLAP
  UB2       TRL_MAXBODY_DWN
  UB4       HDR_RPTON
  UB4       MAI_RPTON
  UB4       TRL_RPTON
END

DESCRIBE  SRW2_DATA_MODEL
BEGIN
  UB4       ITEMID
  UB4       SETTINGS
  SB2       ZOOMPOWER
  SB4       WINDOW_X
  SB4       WINDOW_Y
  SB4       WINDOW_WD
  SB4       WINDOW_HT
  UB2       DFLT_TYPE
  UB4       UIFLAGS
  SB4       GRIDINTC
  SB4       GRIDSNPC
  UB1       HALIGN
  UB1       VALIGN
  SB4       DECURREF_ID
  UB4       GRPMAXROW
  ORADATE   MOD_DATE
  UB1       PERS_FLAGS
  UB1       MUST_SPLIT
  UB1       MAY_SPLIT
  UB2       MIN_TRUNC
  UB1       MIN_PNT_SZ
  TEXT      TMPL_NAME
  UB1       TMPL_CUST
  TEXT      MAIL_TEXT
  TEXT      TEXT_FILE
  TEXT      IMAGE_FILE
  TEXT      VERS_FLAGS
  TEXT      TEXTESC_BR
  TEXT      TEXTESC_AR
  TEXT      TEXTESC_BP
  TEXT      TEXTESC_AP
  TEXT      TEXTESC_BF
  TEXT      TEXTESC_AF
  TEXT      FILEESC_BR
  TEXT      FILEESC_AR
  TEXT      FILEESC_BP
  TEXT      FILEESC_AP
  TEXT      FILEESC_BF
  TEXT      FILEESC_AF
  UB4       ESCTYPES
  TEXT      SECTION_TITLE
  TEXT      FILEESC_MJ
  TLONG     TEXTESC_MJ_ID
  TEXT      XML_TAG
  TEXT      XML_ATTR
  UB1       XML_SUPPRESS
  UB1       PROLOG_TYPE
  TEXT      TEXT_PROLOG
  TEXT      FILE_PROLOG
  UB1       XML_INCLUDEDTD
  VARCHAR   HTMLBUF
  TLONG     HTMLBUFID
  VARCHAR   SAVHTMLBUF
END

DESCRIBE  SRW2_PARAM_FORM
BEGIN
  UB4       ITEMID
  UB4       SETTINGS
  SB2       ZOOMPOWER
  UB1       UNITS
  SB4       UNITS_WID
  SB4       UNITS_HGT
  SB4       FORM_WID
  SB4       FORM_HGT
  SB4       CHAR_WID
  SB4       CHAR_HGT
  SB4       WINDOW_X
  SB4       WINDOW_Y
  SB4       WINDOW_WD
  SB4       WINDOW_HT
  UB4       UIFLAGS
  SB4       GRIDINTC
  SB4       GRIDSNPC
  UB1       HALIGN
  UB1       VALIGN
  SB4       RRECTCNR_WD
  SB4       RRECTCNR_HT
  SB4       SPACING
  UB1       JUSTIFIC
  UB1       ARROWSTYLE
  UB4       UITAG
  UB2       PAGE_TOT
  TEXT      DFLT_TITLE
  TEXT      DFLT_HINT
  TEXT      DFLT_STATUS
  UB1       PERS_FLAGS
END

DESCRIBE  TOOL_MODULE
BEGIN
  VARCHAR   PRODUCT
  VARCHAR   MODTYPE
  VARCHAR   OWNER
  VARCHAR   MODNAME
  UB4       MODID
  UB4       TCS_VER
  UB4       NEXT_ITEMID
  VARCHAR   CREATOR
  ORADATE   CREATE_DATE
  UB4       CREATE_VER
  VARCHAR   MODIFIER
  ORADATE   MOD_DATE
  UB4       MOD_VER
  VARCHAR   COPYRIGHT
  VARCHAR   REQ_ROLE
  UB4       VGS_VER
  UB4       DE_VER
  UB4       ROS_VER
  TEXT      REPLANG
  TEXT      TITLE
  TEXT      AUTHOR
  TEXT      SUBJECT
  TEXT      KEYWORD
  UB1       FORMAT_ORDER
  TEXT      STYLE_SHEETS
  TEXT      CSS_CLASS 
  TEXT      RWTB 
END

DESCRIBE  SRW2_LAYOUT_GROUP
BEGIN
  UB4       ITEMID
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  UB4       NCHILDREN
  UB1       PERS_FLAGS
END

DESCRIBE  ROSSTRINGS
BEGIN
  UB4       groupid
  UB4       stringid
  UB4       lfid
  UB2       cs
  UB2       len
  BINARY    len:str
END

DESCRIBE  SRW2_BUTTON
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  UB1       TYPE
  UB4       SOURCE
  TEXT      SRCFILE
  UB1       ICONIC
  TEXT      LOOKSTR
  UB4       BIDI_DIR
  UB1       PERS_FLAGS
END

DESCRIBE  SRW2_HYPERLINK
BEGIN
  UB2       HYPL_FLAGS
  UB4       OBJECT_ID
  TEXT      TAG_NAME
  TEXT      LINK_TODOC
  TEXT      LINKACTION
  TEXT      OUT_TITLE
  TEXT      IMAGE_NAME
  TEXT      ADDNL_ATTR
  TEXT      HTML_ATTR
  TEXT      TABLE_ATTR
  TEXT      ID
  TEXT      CSS_CLASS
  TEXT      CSS_ID
END

DESCRIBE  SRW2_GROUP_NODE
BEGIN
  UB4       ITEMID
  UB4       NULL_IND1
  UB4       NULL_IND2
  UB4       DELTA_NULL
  UB4       DELTA_HFR
  UB4       DELTA_VFR
  UB4       DELTA_HMD
  UB4       DELTA_VMD
  UB4       DELTA_HSB
  UB4       DELTA_VSB
  UB4       DELTA_HFL
  UB4       DELTA_VFL
  UB4       DELTA_HIF
  UB4       DELTA_VIF
  UB4       DELTA_HPF
  UB4       DELTA_HPG
  UB4       DELTA_VPG
  UB4       DELTA_HCH
  UB4       DELTA_VCH
  UB1       JUSTIFY
  UB1       GROUPSTYLE
  UB1       PLACEBELOW
  UB2       FLDSPERLINE
  UB1       VERTSPACE
  UB2       LISTID
  UB2       LISTPOS
  UB1       PLACEABOVE
  UB1       ALIGNSUMS
END

DESCRIBE  SRW2_JAVA_APPLET
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  UB4       GROUP_ID
  UB1       PERS_FLAGS
  TEXT      DATA_FILE_LOC
  TEXT      DATA_FILE_SRC
  UB4       PLACE_ID
  UB4       GRP_TOP_ID
  UB4       GRP_BOT_ID
END

DESCRIBE  SRW2_JAVA_PROPERTIES
BEGIN
  UB1       PERS_FLAGS
  UB4       JAVA_APPLET_ID
  UB4       PROPERTY_FLAG
  TEXT      NAME
  UB4       TAG_ID
  TEXT      VALUE
  TEXT      EXTENSION
  UB4       LOVLISTID
END

DESCRIBE  SRW2_FORMAT_EXCEPTION
BEGIN
  UB4       OBJECT_ID
  UB4       ACTIVATE
  UB4       TAG
  UB4       NULLVALS
  UB1       DISPLAYED
  TEXT      EXP_LABEL
  UB4       SRCCOL1
  UB1       EXCEPTION1
  TEXT      LOVAL1
  TEXT      HIVAL1
  UB1       CONJUNCT1
  UB4       SRCCOL2
  UB1       EXCEPTION2
  TEXT      LOVAL2
  TEXT      HIVAL2
  UB1       CONJUNCT2
  UB4       SRCCOL3
  UB1       EXCEPTION3
  TEXT      LOVAL3
  TEXT      HIVAL3
  UB1       CONJUNCT3
END

DESCRIBE  SRW2_DISTRIBUTION
BEGIN
  UB4       ITEMID
  TEXT      DISTID
  UB1       LYTYPE
  UB2       COPIES
  UB1       SPOOL
  TEXT      DESNAME
  UB4       DESTYPE
  UB4       DESFORMAT
END

DESCRIBE  SRW2_FORMFIELD
BEGIN
  UB4       ITEMID
  TEXT      NAME
  UB4       TAG
  UB2       DISP_ORDER
  UB4       FORMATFLAG
  TEXT      PRE_CODE
  TEXT      POST_CODE
  SB4       X
  SB4       Y
  SB4       WD
  SB4       HT
  UB2       PAGE
  UB1       TYPE
  UB4       TABORDER
  TEXT      DESCRIPTION
  UB1       READONLY
  UB1       VISIBILITY
  UB1       REQUIRED
  SB4       ORIENTATION
  UB1       ALIGNMENT
  UB1       MULTILINE
  UB1       SCROLL
  UB4       MAXCHARS
  UB1       SPELLCHECK
  UB1       CHECKSTYLE
  TEXT      EXPORTVALUE
  UB1       ISCHECKED
  UB1       TIMEFORMAT
  TEXT      DATEFORMAT
  TEXT      VALSCRIPT
END

DESCRIBE  SRW2_ACTION
BEGIN
  UB4       FORMID
  UB1       EVENT
  UB1       TYPE
  TEXT      VALUE
END

DESCRIBE  SRW2_BODY_LOCATION
BEGIN
  SB4       START_X
  SB4       START_Y
  UB2       LOC_ORDER
  UB1       TYPE
END

DESCRIBE  TOOL_ACCESS
BEGIN
  TEXT      GRANTEE
END

DESCRIBE  SRW2_LISTS
BEGIN
  UB4       LISTID
  UB4       POSITION
  UB2       TYPE
  TEXT      CTYPE
END

DESCRIBE  TOOL_LIBRARY
BEGIN
  TEXT      LIBNAME
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 116
   stringid = 0
   lfid = 0
   cs = 178
   len = 12
   str = (BINARY)
<<"
5265706f 72742044 61746500 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 121
   stringid = 0
   lfid = 0
   cs = 178
   len = 3
   str = (BINARY)
<<"
6f660000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 153
   stringid = 0
   lfid = 0
   cs = 178
   len = 12
   str = (BINARY)
<<"
5265706f 72742044 61746500 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 155
   stringid = 0
   lfid = 0
   cs = 178
   len = 18
   str = (BINARY)
<<"
5265706f 72742050 6172616d 65746572 73000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 780
   stringid = 0
   lfid = 0
   cs = 178
   len = 10
   str = (BINARY)
<<"
43617465 676f7279 3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 785
   stringid = 0
   lfid = 0
   cs = 178
   len = 6
   str = (BINARY)
<<"
4974656d 3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 787
   stringid = 0
   lfid = 0
   cs = 178
   len = 13
   str = (BINARY)
<<"
44657363 72697074 696f6e3a 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 1430
   stringid = 0
   lfid = 0
   cs = 178
   len = 26
   str = (BINARY)
<<"
2a2a2a2a 2a204e6f 20446174 6120466f 756e6420 2a2a2a2a 2a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 1432
   stringid = 0
   lfid = 0
   cs = 178
   len = 15
   str = (BINARY)
<<"
4974656d 20537562 746f7461 6c3a0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 1440
   stringid = 0
   lfid = 0
   cs = 178
   len = 19
   str = (BINARY)
<<"
43617465 676f7279 20537562 746f7461 6c3a0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 2045
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
56656e64 6f722053 7562746f 74616c3a 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 2870
   stringid = 0
   lfid = 0
   cs = 178
   len = 19
   str = (BINARY)
<<"
4974656d 20436174 65676f72 79204672 6f6d0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 2872
   stringid = 0
   lfid = 0
   cs = 178
   len = 3
   str = (BINARY)
<<"
546f0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 3041
   stringid = 0
   lfid = 0
   cs = 178
   len = 30
   str = (BINARY)
<<"
496e766f 69636520 50726963 65205661 7269616e 63652052 65706f72 74000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 3057
   stringid = 0
   lfid = 0
   cs = 178
   len = 42
   str = (BINARY)
<<"
496e766f 69636520 50726963 65205661 7269616e 63652062 79204361 7465676f 
72792052 65706f72 74000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 3210
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 3365
   stringid = 0
   lfid = 0
   cs = 178
   len = 12
   str = (BINARY)
<<"
56656e64 6f722046 726f6d00 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 3366
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 3369
   stringid = 0
   lfid = 0
   cs = 178
   len = 10
   str = (BINARY)
<<"
56656e64 6f722054 6f000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 5389
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 5390
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6367
   stringid = 0
   lfid = 0
   cs = 178
   len = 3
   str = (BINARY)
<<"
6f660000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6371
   stringid = 0
   lfid = 0
   cs = 178
   len = 5
   str = (BINARY)
<<"
50616765 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6478
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6483
   stringid = 0
   lfid = 0
   cs = 178
   len = 14
   str = (BINARY)
<<"
5265706f 72742054 6f74616c 3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6729
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
3d3d3d3d 3d3d3d3d 3d3d3d3d 3d3d3d3d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6810
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6812
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6813
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6814
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6815
   stringid = 0
   lfid = 0
   cs = 178
   len = 12
   str = (BINARY)
<<"
50657269 6f64204e 616d6500 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6818
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6820
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6821
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6823
   stringid = 0
   lfid = 0
   cs = 178
   len = 5
   str = (BINARY)
<<"
50616765 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6824
   stringid = 0
   lfid = 0
   cs = 178
   len = 2
   str = (BINARY)
<<"
3a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6825
   stringid = 0
   lfid = 0
   cs = 178
   len = 41
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 
2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6826
   stringid = 0
   lfid = 0
   cs = 178
   len = 7
   str = (BINARY)
<<"
56656e64 6f720000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6827
   stringid = 0
   lfid = 0
   cs = 178
   len = 20
   str = (BINARY)
<<"
504f204e 756d6265 72202d20 52656c65 61736500 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6828
   stringid = 0
   lfid = 0
   cs = 178
   len = 21
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6829
   stringid = 0
   lfid = 0
   cs = 178
   len = 5
   str = (BINARY)
<<"
4c696e65 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6830
   stringid = 0
   lfid = 0
   cs = 178
   len = 5
   str = (BINARY)
<<"
2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6831
   stringid = 0
   lfid = 0
   cs = 178
   len = 26
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6832
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
53686970 2d546f2d 4c6f6361 74696f6e 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6833
   stringid = 0
   lfid = 0
   cs = 178
   len = 9
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6834
   stringid = 0
   lfid = 0
   cs = 178
   len = 9
   str = (BINARY)
<<"
43757272 656e6379 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6835
   stringid = 0
   lfid = 0
   cs = 178
   len = 5
   str = (BINARY)
<<"
556e6974 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6836
   stringid = 0
   lfid = 0
   cs = 178
   len = 8
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d00 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6837
   stringid = 0
   lfid = 0
   cs = 178
   len = 15
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6839
   stringid = 0
   lfid = 0
   cs = 178
   len = 15
   str = (BINARY)
<<"
496e766f 69636520 4e756d62 65720000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6840
   stringid = 0
   lfid = 0
   cs = 178
   len = 13
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6841
   stringid = 0
   lfid = 0
   cs = 178
   len = 13
   str = (BINARY)
<<"
496e766f 69636520 44617465 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6842
   stringid = 0
   lfid = 0
   cs = 178
   len = 11
   str = (BINARY)
<<"
456e7472 79205479 70650000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6843
   stringid = 0
   lfid = 0
   cs = 178
   len = 11
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6844
   stringid = 0
   lfid = 0
   cs = 178
   len = 16
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d00 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6845
   stringid = 0
   lfid = 0
   cs = 178
   len = 13
   str = (BINARY)
<<"
51747920 496e766f 69636564 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6846
   stringid = 0
   lfid = 0
   cs = 178
   len = 14
   str = (BINARY)
<<"
496e766f 69636520 50726963 65000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6847
   stringid = 0
   lfid = 0
   cs = 178
   len = 18
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6848
   stringid = 0
   lfid = 0
   cs = 178
   len = 18
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6849
   stringid = 0
   lfid = 0
   cs = 178
   len = 15
   str = (BINARY)
<<"
504f2046 756e6374 696f6e61 6c0a0000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6849
   stringid = 1
   lfid = 0
   cs = 178
   len = 6
   str = (BINARY)
<<"
50726963 65000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6850
   stringid = 0
   lfid = 0
   cs = 178
   len = 9
   str = (BINARY)
<<"
496e766f 6963650a 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6850
   stringid = 1
   lfid = 0
   cs = 178
   len = 15
   str = (BINARY)
<<"
50726963 65205661 7269616e 63650000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6851
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6852
   stringid = 0
   lfid = 0
   cs = 178
   len = 15
   str = (BINARY)
<<"
43686172 67652041 63636f75 6e740000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6853
   stringid = 0
   lfid = 0
   cs = 178
   len = 36
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 
2d2d2d00 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6854
   stringid = 0
   lfid = 0
   cs = 178
   len = 36
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 
2d2d2d00 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6855
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
56617269 616e6365 20416363 6f756e74 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6940
   stringid = 0
   lfid = 0
   cs = 178
   len = 10
   str = (BINARY)
<<"
45786368 616e6765 0a000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6940
   stringid = 1
   lfid = 0
   cs = 178
   len = 14
   str = (BINARY)
<<"
52617465 20566172 69616e63 65000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6943
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6966
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6973
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6975
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
3d3d3d3d 3d3d3d3d 3d3d3d3d 3d3d3d3d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6977
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  ROSSTRINGS
BEGIN
   groupid = 6980
   stringid = 0
   lfid = 0
   cs = 178
   len = 17
   str = (BINARY)
<<"
2d2d2d2d 2d2d2d2d 2d2d2d2d 2d2d2d2d 00000000 
">>
END

DEFINE  TOOL_MODULE
BEGIN
   PRODUCT = 16
     <<"SQL*ReportWriter">>
   MODTYPE = 6
     <<"REPORT">>
   OWNER = 4
     <<"APPS">>
   MODNAME = 9
     <<"XXCST1741">>
   MODID = 0
   TCS_VER = 16777216
   NEXT_ITEMID = 8385
   CREATOR = 4
     <<"PO70">>
   CREATE_DATE = <<"16792.08.18 10:12:48">>
   CREATE_VER = -67088384
   MODIFIER = 4
     <<"APPS">>
   MOD_DATE = <<"120122.03.09 21:18:42">>
   MOD_VER = -1474166782
   COPYRIGHT = (VARCHAR) NULLP
   REQ_ROLE = (VARCHAR) NULLP
   VGS_VER = 168828928
   DE_VER = 168828930
   ROS_VER = 168828930
   REPLANG = NULLP
   TITLE = NULLP
   AUTHOR = NULLP
   SUBJECT = NULLP
   KEYWORD = NULLP
   FORMAT_ORDER = 0
   STYLE_SHEETS = NULLP
   CSS_CLASS  = NULLP
   RWTB  = NULLP
END

DEFINE  SRW2_LAYOUT
BEGIN
   ITEMID = 100
   SETTINGS = 261777
   ZOOMPOWER = 0
   UNITS = 1
   ORIENT = 247
   UNITS_WID = 79277
   UNITS_HGT = 110000
   CHAR_WID = 132
   CHAR_HGT = 66
   BODY_WID = 64944
   BODY_HGT = 84650
   PAGE_WID = 64944
   PAGE_HGT = 90112
   PRINT_WID = 64944
   PRINT_HGT = 90112
   X_PANELS = 1
   Y_PANELS = 1
   HEADERS = 1
   TRAILERS = 0
   WINDOW_X = 24
   WINDOW_Y = 88
   WINDOW_WD = 1102
   WINDOW_HT = 770
   RUN_FLAGS = 256
   TITLE = NULLP
   HINT = NULLP
   STATUS = NULLP
   MAXHEADERS = 10
   MAXTRAILERS = 10
   MAXBODY_ACR = 10
   MAXBODY_DWN = 10
   INTERN_VER = 191
   INTERN_VER2 = 178
   APPLSTATE = 0
   UIFLAGS = 1022
   GRIDINTC = 1
   GRIDSNPC = 1
   HALIGN = 0
   VALIGN = 2
   RRECTCNR_WD = 1130
   RRECTCNR_HT = 1130
   SPACING = 0
   JUSTIFIC = 32
   ARROWSTYLE = 0
   UITAG = 6938
   NEXTLISTID = 1
   IDROLESLIST = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   HDR_UNITS_WID = 79277
   HDR_UNITS_HGT = 110000
   HDR_CHAR_WID = 132
   HDR_CHAR_HGT = 66
   HDR_BODY_WID = 64944
   HDR_BODY_HGT = 90112
   HDR_PAGE_WID = 64944
   HDR_PAGE_HGT = 90112
   HDR_PRINT_WID = 64944
   HDR_PRINT_HGT = 90112
   HDR_X_PANELS = 1
   HDR_Y_PANELS = 1
   TRL_UNITS_WID = 79277
   TRL_UNITS_HGT = 110000
   TRL_CHAR_WID = 132
   TRL_CHAR_HGT = 66
   TRL_BODY_WID = 64944
   TRL_BODY_HGT = 90112
   TRL_PAGE_WID = 64944
   TRL_PAGE_HGT = 90112
   TRL_PRINT_WID = 64944
   TRL_PRINT_HGT = 90112
   TRL_X_PANELS = 1
   TRL_Y_PANELS = 1
   HDR_MAXBODY_ACR = 10
   HDR_MAXBODY_DWN = 10
   TRL_MAXBODY_ACR = 10
   DIST_OVERLAP = 0
   TRL_MAXBODY_DWN = 10
   HDR_RPTON = 17
   MAI_RPTON = 17
   TRL_RPTON = 17
END

DEFINE  SRW2_BODY_LOCATION
BEGIN
   START_X = 0
   START_Y = 2731
   LOC_ORDER = 0
   TYPE = 1
END

DEFINE  SRW2_BODY_LOCATION
BEGIN
   START_X = 0
   START_Y = 0
   LOC_ORDER = 0
   TYPE = 2
END

DEFINE  SRW2_BODY_LOCATION
BEGIN
   START_X = 0
   START_Y = 0
   LOC_ORDER = 0
   TYPE = 3
END

DEFINE  SRW2_DATA_MODEL
BEGIN
   ITEMID = 101
   SETTINGS = 0
   ZOOMPOWER = 0
   WINDOW_X = 378
   WINDOW_Y = 70
   WINDOW_WD = 833
   WINDOW_HT = 756
   DFLT_TYPE = 3
   UIFLAGS = 16576
   GRIDINTC = 1
   GRIDSNPC = 4
   HALIGN = 0
   VALIGN = 0
   DECURREF_ID = 86
   GRPMAXROW = 0
   MOD_DATE = <<"1900.00.00 00:00:00">>
   PERS_FLAGS = 0
   MUST_SPLIT = 0
   MAY_SPLIT = 0
   MIN_TRUNC = 0
   MIN_PNT_SZ = 0
   TMPL_NAME = NULLP
   TMPL_CUST = 0
   MAIL_TEXT = NULLP
   TEXT_FILE = NULLP
   IMAGE_FILE = NULLP
   VERS_FLAGS = NULLP
   TEXTESC_BR = <<"<html>
<body dir=&Direction bgcolor="#ffffff">
">>
   TEXTESC_AR = <<"</body></html>
">>
   TEXTESC_BP = <<"<html>
<body dir=&Direction bgcolor="#ffffff">
<form method=post action="_action_">
<input name="hidden_run_parameters" type=hidden value="_hidden_">
<center>
<p><table border=0 cellspacing=0 cellpadding=0>
<tr>
<td><input type=submit></td>
<td width=15>
<td><input type=reset></td>
</tr>
</table>
<p><hr><p>
">>
   TEXTESC_AP = <<"</center>
</body>
</form>
</html>
">>
   TEXTESC_BF = NULLP
   TEXTESC_AF = <<"<hr size=5 noshade>
">>
   FILEESC_BR = NULLP
   FILEESC_AR = NULLP
   FILEESC_BP = NULLP
   FILEESC_AP = NULLP
   FILEESC_BF = NULLP
   FILEESC_AF = NULLP
   ESCTYPES = 0
   SECTION_TITLE = NULLP
   FILEESC_MJ = NULLP
   TEXTESC_MJ_ID = (TLONG)
<<"<HTML>
<TITLE>Oracle HTML Navigator</TITLE>
<HEAD>
<SCRIPT LANGUAGE = "JavaScript">

var jump_index = 1			// Jump to this page
var num_pages = &TotalPages			// Total number of pages
var basefilename = "&file_name"		// Base file name
var fileext = "&file_ext"		//File extension

/* jumps to "new_page" */
function new_page(form, new_page)
{
	form.reqpage.value = new_page;
	parent.frames[0].location = basefilename + "_" + new_page + "."+fileext;
}

/* go back one page */
function back(form)
{
	/* if we are not in first page */
	if (jump_index > 1)
	{
		jump_index--;
		new_page(form, jump_index);
	}
}

/* go forward one page */
function forward(form)
{
	/* if we are not in last page */
	if (jump_index < num_pages)
	{
		jump_index++;
		new_page(form, jump_index);
	}
}

/* go to first page */
function first(form)
{
	if(jump_index != 1)
	{
		jump_index = 1;
		new_page(form, jump_index);
	}
}

/* go to last page */
function last(form)
{
	if(jump_index != num_pages)
	{
		jump_index = num_pages;
		new_page(form, jump_index);
	}
}

/* go to the user specified page number */
function pagenum(form)
{
	/* sanity check */
	if (form.reqpage.value < 1)
	{
		form.reqpage.value = 1;
	}
	if (form.reqpage.value > num_pages)
	{
		form.reqpage.value = num_pages;
	}
	jump_index = form.reqpage.value;
	new_page(form, jump_index);
}
</SCRIPT>
</HEAD>

<BODY>
<FORM NAME="ThisForm" onSubmit="pagenum(this); return false;">
<center><table><tr>
<td> <INPUT TYPE="button"  VALUE="<< " onClick="first(this.form)">
<td> <INPUT TYPE="button"  VALUE=" < " onClick="back(this.form)">
<td> <INPUT TYPE="button"  VALUE="Page:" onClick="pagenum(this.form)">
<td> <INPUT NAME="reqpage" VALUE="1" SIZE=2>
<td> <INPUT TYPE="button"  VALUE=" > " onClick="forward(this.form)">
<td> <INPUT TYPE="button"  VALUE=" >>" onClick="last(this.form)">
</table></center>
</FORM></BODY>
</HTML>
">>
   XML_TAG = <<"XXCST1741">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   PROLOG_TYPE = 0
   TEXT_PROLOG = <<"<?xml version="1.0" encoding="UTF-8" ?>">>
   FILE_PROLOG = NULLP
   XML_INCLUDEDTD = 0
   HTMLBUF = (VARCHAR) NULLP
   HTMLBUFID = (TLONG)
<<"<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
</rw:objects>
-->

<html>

<head>
<meta name="GENERATOR" content="Oracle 9i Reports Developer"/>
<title> Your Title </title>

<rw:style id="yourStyle">
   <!-- Report Wizard inserts style link clause here -->
</rw:style>

</head>


<body>

<rw:dataArea id="yourDataArea">
   <!-- Report Wizard inserts the default jsp here -->
</rw:dataArea>



</body>
</html>

<!--
</rw:report> 
-->
">>
   SAVHTMLBUF = (VARCHAR) NULLP
END

DEFINE  SRW2_PARAM_FORM
BEGIN
   ITEMID = 102
   SETTINGS = 130705
   ZOOMPOWER = 0
   UNITS = 1
   UNITS_WID = 40000
   UNITS_HGT = 40000
   FORM_WID = 32768
   FORM_HGT = 32768
   CHAR_WID = 80
   CHAR_HGT = 24
   WINDOW_X = 280
   WINDOW_Y = 158
   WINDOW_WD = 700
   WINDOW_HT = 700
   UIFLAGS = 1006
   GRIDINTC = 1
   GRIDSNPC = 4
   HALIGN = 0
   VALIGN = 0
   RRECTCNR_WD = 1130
   RRECTCNR_HT = 1130
   SPACING = -1
   JUSTIFIC = 16
   ARROWSTYLE = 0
   UITAG = 6293
   PAGE_TOT = 2
   DFLT_TITLE = <<"Invoice Price Variance Report">>
   DFLT_HINT = NULLP
   DFLT_STATUS = <<"Report: POXRCIPV4">>
   PERS_FLAGS = 0
END

DESCRIBE  VG_COLOR
BEGIN
  SB4       ITEMID
  SB4       CELLID
  UB2       NAME_SET
  UB2       NAME_LENGTH
  BINARY    NAME_LENGTH:COLOR_NAME
  UB2       RED
  UB2       GREEN
  UB2       BLUE
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 0
   NAME_SET = 0
   NAME_LENGTH = 5
   COLOR_NAME = (BINARY)
<<"
626c6163 6b000000 
">>
   RED = 0
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 1
   NAME_SET = 0
   NAME_LENGTH = 5
   COLOR_NAME = (BINARY)
<<"
77686974 65000000 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 2
   NAME_SET = 0
   NAME_LENGTH = 5
   COLOR_NAME = (BINARY)
<<"
67726565 6e000000 
">>
   RED = 0
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 3
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
6461726b 67726565 6e000000 
">>
   RED = 0
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 4
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 39360000 
">>
   RED = 2621
   GREEN = 2621
   BLUE = 2621
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 5
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 39320000 
">>
   RED = 5242
   GREEN = 5242
   BLUE = 5242
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 6
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 38380000 
">>
   RED = 7864
   GREEN = 7864
   BLUE = 7864
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 7
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 38340000 
">>
   RED = 10485
   GREEN = 10485
   BLUE = 10485
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 8
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
72306730 62300000 
">>
   RED = 0
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 9
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72323567 30623000 
">>
   RED = 16384
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 10
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72353067 30623000 
">>
   RED = 32768
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 11
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72373567 30623000 
">>
   RED = 49152
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 12
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72383867 30623000 
">>
   RED = 57344
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 13
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72313030 67306230 
">>
   RED = 65535
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 14
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306730 62353000 
">>
   RED = 0
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 15
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 30623530 
">>
   RED = 16384
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 16
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 30623530 
">>
   RED = 32768
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 17
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 30623530 
">>
   RED = 49152
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 18
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 30623530 
">>
   RED = 57344
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 19
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67306235 30000000 
">>
   RED = 65535
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 20
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306730 62373500 
">>
   RED = 0
   GREEN = 0
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 21
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 30623735 
">>
   RED = 16384
   GREEN = 0
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 22
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 30623735 
">>
   RED = 32768
   GREEN = 0
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 23
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 30623735 
">>
   RED = 49152
   GREEN = 0
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 24
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 30623735 
">>
   RED = 57344
   GREEN = 0
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 25
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67306237 35000000 
">>
   RED = 65535
   GREEN = 0
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 26
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306730 62383800 
">>
   RED = 0
   GREEN = 0
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 27
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 30623838 
">>
   RED = 16384
   GREEN = 0
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 28
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 30623838 
">>
   RED = 32768
   GREEN = 0
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 29
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 30623838 
">>
   RED = 49152
   GREEN = 0
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 30
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 30623838 
">>
   RED = 57344
   GREEN = 0
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 31
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67306238 38000000 
">>
   RED = 65535
   GREEN = 0
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 32
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306730 62313030 
">>
   RED = 0
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 33
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 30623130 30000000 
">>
   RED = 16384
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 34
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 30623130 30000000 
">>
   RED = 32768
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 35
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 30623130 30000000 
">>
   RED = 49152
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 36
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 30623130 30000000 
">>
   RED = 57344
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 37
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67306231 30300000 
">>
   RED = 65535
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 38
   NAME_SET = 0
   NAME_LENGTH = 4
   COLOR_NAME = (BINARY)
<<"
67726179 
">>
   RED = 49152
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 39
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
6461726b 67726179 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 40
   NAME_SET = 0
   NAME_LENGTH = 4
   COLOR_NAME = (BINARY)
<<"
6379616e 
">>
   RED = 0
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 41
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
6461726b 6379616e 
">>
   RED = 0
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 42
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 38300000 
">>
   RED = 13107
   GREEN = 13107
   BLUE = 13107
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 43
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 37360000 
">>
   RED = 15728
   GREEN = 15728
   BLUE = 15728
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 44
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 37320000 
">>
   RED = 18350
   GREEN = 18350
   BLUE = 18350
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 45
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 36380000 
">>
   RED = 20971
   GREEN = 20971
   BLUE = 20971
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 46
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306732 35623000 
">>
   RED = 0
   GREEN = 16384
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 47
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 32356230 
">>
   RED = 16384
   GREEN = 16384
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 48
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 32356230 
">>
   RED = 32768
   GREEN = 16384
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 49
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 32356230 
">>
   RED = 49152
   GREEN = 16384
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 50
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 32356230 
">>
   RED = 57344
   GREEN = 16384
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 51
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67323562 30000000 
">>
   RED = 65535
   GREEN = 16384
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 52
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306732 35623530 
">>
   RED = 0
   GREEN = 16384
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 53
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 32356235 30000000 
">>
   RED = 16384
   GREEN = 16384
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 54
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 32356235 30000000 
">>
   RED = 32768
   GREEN = 16384
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 55
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 32356235 30000000 
">>
   RED = 49152
   GREEN = 16384
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 56
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 32356235 30000000 
">>
   RED = 57344
   GREEN = 16384
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 57
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67323562 35300000 
">>
   RED = 65535
   GREEN = 16384
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 58
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306732 35623735 
">>
   RED = 0
   GREEN = 16384
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 59
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 32356237 35000000 
">>
   RED = 16384
   GREEN = 16384
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 60
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 32356237 35000000 
">>
   RED = 32768
   GREEN = 16384
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 61
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 32356237 35000000 
">>
   RED = 49152
   GREEN = 16384
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 62
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 32356237 35000000 
">>
   RED = 57344
   GREEN = 16384
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 63
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67323562 37350000 
">>
   RED = 65535
   GREEN = 16384
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 64
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306732 35623838 
">>
   RED = 0
   GREEN = 16384
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 65
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 32356238 38000000 
">>
   RED = 16384
   GREEN = 16384
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 66
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 32356238 38000000 
">>
   RED = 32768
   GREEN = 16384
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 67
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 32356238 38000000 
">>
   RED = 49152
   GREEN = 16384
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 68
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 32356238 38000000 
">>
   RED = 57344
   GREEN = 16384
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 69
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67323562 38380000 
">>
   RED = 65535
   GREEN = 16384
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 70
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306732 35623130 30000000 
">>
   RED = 0
   GREEN = 16384
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 71
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 32356231 30300000 
">>
   RED = 16384
   GREEN = 16384
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 72
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 32356231 30300000 
">>
   RED = 32768
   GREEN = 16384
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 73
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 32356231 30300000 
">>
   RED = 49152
   GREEN = 16384
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 74
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 32356231 30300000 
">>
   RED = 57344
   GREEN = 16384
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 75
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67323562 31303000 
">>
   RED = 65535
   GREEN = 16384
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 76
   NAME_SET = 0
   NAME_LENGTH = 3
   COLOR_NAME = (BINARY)
<<"
72656400 
">>
   RED = 65535
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 77
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
6461726b 72656400 
">>
   RED = 32768
   GREEN = 0
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 78
   NAME_SET = 0
   NAME_LENGTH = 4
   COLOR_NAME = (BINARY)
<<"
626c7565 
">>
   RED = 0
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 79
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
6461726b 626c7565 
">>
   RED = 0
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 80
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 36340000 
">>
   RED = 23592
   GREEN = 23592
   BLUE = 23592
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 81
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 36300000 
">>
   RED = 26214
   GREEN = 26214
   BLUE = 26214
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 82
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 35360000 
">>
   RED = 28835
   GREEN = 28835
   BLUE = 28835
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 83
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 35320000 
">>
   RED = 31457
   GREEN = 31457
   BLUE = 31457
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 84
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306735 30623000 
">>
   RED = 0
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 85
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 35306230 
">>
   RED = 16384
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 86
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 35306230 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 87
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 35306230 
">>
   RED = 49152
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 88
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 35306230 
">>
   RED = 57344
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 89
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67353062 30000000 
">>
   RED = 65535
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 90
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306735 30623530 
">>
   RED = 0
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 91
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 35306235 30000000 
">>
   RED = 16384
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 92
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 35306235 30000000 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 93
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 35306235 30000000 
">>
   RED = 49152
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 94
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 35306235 30000000 
">>
   RED = 57344
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 95
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67353062 35300000 
">>
   RED = 65535
   GREEN = 32768
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 96
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306735 30623735 
">>
   RED = 0
   GREEN = 32768
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 97
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 35306237 35000000 
">>
   RED = 16384
   GREEN = 32768
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 98
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 35306237 35000000 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 99
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 35306237 35000000 
">>
   RED = 49152
   GREEN = 32768
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 100
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 35306237 35000000 
">>
   RED = 57344
   GREEN = 32768
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 101
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67353062 37350000 
">>
   RED = 65535
   GREEN = 32768
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 102
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306735 30623838 
">>
   RED = 0
   GREEN = 32768
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 103
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 35306238 38000000 
">>
   RED = 16384
   GREEN = 32768
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 104
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 35306238 38000000 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 105
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 35306238 38000000 
">>
   RED = 49152
   GREEN = 32768
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 106
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 35306238 38000000 
">>
   RED = 57344
   GREEN = 32768
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 107
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67353062 38380000 
">>
   RED = 65535
   GREEN = 32768
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 108
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306735 30623130 30000000 
">>
   RED = 0
   GREEN = 32768
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 109
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 35306231 30300000 
">>
   RED = 16384
   GREEN = 32768
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 110
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 35306231 30300000 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 111
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 35306231 30300000 
">>
   RED = 49152
   GREEN = 32768
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 112
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 35306231 30300000 
">>
   RED = 57344
   GREEN = 32768
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 113
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67353062 31303000 
">>
   RED = 65535
   GREEN = 32768
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 114
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
79656c6c 6f770000 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 115
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
6461726b 79656c6c 6f770000 
">>
   RED = 32768
   GREEN = 32768
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 116
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
6d616765 6e746100 
">>
   RED = 65535
   GREEN = 0
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 117
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
6461726b 6d616765 6e746100 
">>
   RED = 32768
   GREEN = 0
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 118
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 34380000 
">>
   RED = 34078
   GREEN = 34078
   BLUE = 34078
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 119
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 34340000 
">>
   RED = 36700
   GREEN = 36700
   BLUE = 36700
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 120
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 34300000 
">>
   RED = 39321
   GREEN = 39321
   BLUE = 39321
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 121
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 33360000 
">>
   RED = 41943
   GREEN = 41943
   BLUE = 41943
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 122
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306737 35623000 
">>
   RED = 0
   GREEN = 49152
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 123
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 37356230 
">>
   RED = 16384
   GREEN = 49152
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 124
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 37356230 
">>
   RED = 32768
   GREEN = 49152
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 125
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 37356230 
">>
   RED = 49152
   GREEN = 49152
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 126
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 37356230 
">>
   RED = 57344
   GREEN = 49152
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 127
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67373562 30000000 
">>
   RED = 65535
   GREEN = 49152
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 128
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306737 35623530 
">>
   RED = 0
   GREEN = 49152
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 129
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 37356235 30000000 
">>
   RED = 16384
   GREEN = 49152
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 130
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 37356235 30000000 
">>
   RED = 32768
   GREEN = 49152
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 131
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 37356235 30000000 
">>
   RED = 49152
   GREEN = 49152
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 132
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 37356235 30000000 
">>
   RED = 57344
   GREEN = 49152
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 133
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67373562 35300000 
">>
   RED = 65535
   GREEN = 49152
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 134
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306737 35623735 
">>
   RED = 0
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 135
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 37356237 35000000 
">>
   RED = 16384
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 136
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 37356237 35000000 
">>
   RED = 32768
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 137
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 37356237 35000000 
">>
   RED = 49152
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 138
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 37356237 35000000 
">>
   RED = 57344
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 139
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67373562 37350000 
">>
   RED = 65535
   GREEN = 49152
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 140
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306737 35623838 
">>
   RED = 0
   GREEN = 49152
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 141
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 37356238 38000000 
">>
   RED = 16384
   GREEN = 49152
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 142
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 37356238 38000000 
">>
   RED = 32768
   GREEN = 49152
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 143
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 37356238 38000000 
">>
   RED = 49152
   GREEN = 49152
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 144
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 37356238 38000000 
">>
   RED = 57344
   GREEN = 49152
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 145
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67373562 38380000 
">>
   RED = 65535
   GREEN = 49152
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 146
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306737 35623130 30000000 
">>
   RED = 0
   GREEN = 49152
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 147
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 37356231 30300000 
">>
   RED = 16384
   GREEN = 49152
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 148
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 37356231 30300000 
">>
   RED = 32768
   GREEN = 49152
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 149
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 37356231 30300000 
">>
   RED = 49152
   GREEN = 49152
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 150
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 37356231 30300000 
">>
   RED = 57344
   GREEN = 49152
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 151
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67373562 31303000 
">>
   RED = 65535
   GREEN = 49152
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 152
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3100 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 153
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3200 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 154
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3300 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 155
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3400 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 156
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 33320000 
">>
   RED = 44564
   GREEN = 44564
   BLUE = 44564
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 157
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 32380000 
">>
   RED = 47185
   GREEN = 47185
   BLUE = 47185
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 158
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 32340000 
">>
   RED = 49807
   GREEN = 49807
   BLUE = 49807
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 159
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 32300000 
">>
   RED = 52428
   GREEN = 52428
   BLUE = 52428
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 160
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
72306738 38623000 
">>
   RED = 0
   GREEN = 57344
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 161
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72323567 38386230 
">>
   RED = 16384
   GREEN = 57344
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 162
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72353067 38386230 
">>
   RED = 32768
   GREEN = 57344
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 163
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72373567 38386230 
">>
   RED = 49152
   GREEN = 57344
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 164
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72383867 38386230 
">>
   RED = 57344
   GREEN = 57344
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 165
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72313030 67383862 30000000 
">>
   RED = 65535
   GREEN = 57344
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 166
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306738 38623530 
">>
   RED = 0
   GREEN = 57344
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 167
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 38386235 30000000 
">>
   RED = 16384
   GREEN = 57344
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 168
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 38386235 30000000 
">>
   RED = 32768
   GREEN = 57344
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 169
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 38386235 30000000 
">>
   RED = 49152
   GREEN = 57344
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 170
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 38386235 30000000 
">>
   RED = 57344
   GREEN = 57344
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 171
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67383862 35300000 
">>
   RED = 65535
   GREEN = 57344
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 172
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306738 38623735 
">>
   RED = 0
   GREEN = 57344
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 173
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 38386237 35000000 
">>
   RED = 16384
   GREEN = 57344
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 174
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 38386237 35000000 
">>
   RED = 32768
   GREEN = 57344
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 175
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 38386237 35000000 
">>
   RED = 49152
   GREEN = 57344
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 176
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 38386237 35000000 
">>
   RED = 57344
   GREEN = 57344
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 177
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67383862 37350000 
">>
   RED = 65535
   GREEN = 57344
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 178
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306738 38623838 
">>
   RED = 0
   GREEN = 57344
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 179
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 38386238 38000000 
">>
   RED = 16384
   GREEN = 57344
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 180
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 38386238 38000000 
">>
   RED = 32768
   GREEN = 57344
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 181
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 38386238 38000000 
">>
   RED = 49152
   GREEN = 57344
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 182
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 38386238 38000000 
">>
   RED = 57344
   GREEN = 57344
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 183
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67383862 38380000 
">>
   RED = 65535
   GREEN = 57344
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 184
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306738 38623130 30000000 
">>
   RED = 0
   GREEN = 57344
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 185
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 38386231 30300000 
">>
   RED = 16384
   GREEN = 57344
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 186
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 38386231 30300000 
">>
   RED = 32768
   GREEN = 57344
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 187
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 38386231 30300000 
">>
   RED = 49152
   GREEN = 57344
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 188
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 38386231 30300000 
">>
   RED = 57344
   GREEN = 57344
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 189
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67383862 31303000 
">>
   RED = 65535
   GREEN = 57344
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 190
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3500 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 191
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3600 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 192
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3700 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 193
   NAME_SET = 0
   NAME_LENGTH = 7
   COLOR_NAME = (BINARY)
<<"
63757374 6f6d3800 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 194
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 31360000 
">>
   RED = 55050
   GREEN = 55050
   BLUE = 55050
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 195
   NAME_SET = 0
   NAME_LENGTH = 6
   COLOR_NAME = (BINARY)
<<"
67726179 31320000 
">>
   RED = 57671
   GREEN = 57671
   BLUE = 57671
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 196
   NAME_SET = 0
   NAME_LENGTH = 5
   COLOR_NAME = (BINARY)
<<"
67726179 38000000 
">>
   RED = 60293
   GREEN = 60293
   BLUE = 60293
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 197
   NAME_SET = 0
   NAME_LENGTH = 5
   COLOR_NAME = (BINARY)
<<"
67726179 34000000 
">>
   RED = 62914
   GREEN = 62914
   BLUE = 62914
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 198
   NAME_SET = 0
   NAME_LENGTH = 8
   COLOR_NAME = (BINARY)
<<"
72306731 30306230 
">>
   RED = 0
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 199
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72323567 31303062 30000000 
">>
   RED = 16384
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 200
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72353067 31303062 30000000 
">>
   RED = 32768
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 201
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72373567 31303062 30000000 
">>
   RED = 49152
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 202
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72383867 31303062 30000000 
">>
   RED = 57344
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 203
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72313030 67313030 62300000 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 0
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 204
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306731 30306235 30000000 
">>
   RED = 0
   GREEN = 65535
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 205
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 31303062 35300000 
">>
   RED = 16384
   GREEN = 65535
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 206
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 31303062 35300000 
">>
   RED = 32768
   GREEN = 65535
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 207
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 31303062 35300000 
">>
   RED = 49152
   GREEN = 65535
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 208
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 31303062 35300000 
">>
   RED = 57344
   GREEN = 65535
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 209
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67313030 62353000 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 32768
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 210
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306731 30306237 35000000 
">>
   RED = 0
   GREEN = 65535
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 211
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 31303062 37350000 
">>
   RED = 16384
   GREEN = 65535
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 212
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 31303062 37350000 
">>
   RED = 32768
   GREEN = 65535
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 213
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 31303062 37350000 
">>
   RED = 49152
   GREEN = 65535
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 214
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 31303062 37350000 
">>
   RED = 57344
   GREEN = 65535
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 215
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67313030 62373500 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 49152
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 216
   NAME_SET = 0
   NAME_LENGTH = 9
   COLOR_NAME = (BINARY)
<<"
72306731 30306238 38000000 
">>
   RED = 0
   GREEN = 65535
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 217
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72323567 31303062 38380000 
">>
   RED = 16384
   GREEN = 65535
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 218
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72353067 31303062 38380000 
">>
   RED = 32768
   GREEN = 65535
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 219
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72373567 31303062 38380000 
">>
   RED = 49152
   GREEN = 65535
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 220
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72383867 31303062 38380000 
">>
   RED = 57344
   GREEN = 65535
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 221
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72313030 67313030 62383800 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 57344
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 222
   NAME_SET = 0
   NAME_LENGTH = 10
   COLOR_NAME = (BINARY)
<<"
72306731 30306231 30300000 
">>
   RED = 0
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 223
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72323567 31303062 31303000 
">>
   RED = 16384
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 224
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72353067 31303062 31303000 
">>
   RED = 32768
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 225
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72373567 31303062 31303000 
">>
   RED = 49152
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 226
   NAME_SET = 0
   NAME_LENGTH = 11
   COLOR_NAME = (BINARY)
<<"
72383867 31303062 31303000 
">>
   RED = 57344
   GREEN = 65535
   BLUE = 65535
END

DEFINE  VG_COLOR
BEGIN
   ITEMID = 0
   CELLID = 227
   NAME_SET = 0
   NAME_LENGTH = 12
   COLOR_NAME = (BINARY)
<<"
72313030 67313030 62313030 
">>
   RED = 65535
   GREEN = 65535
   BLUE = 65535
END

DEFINE  SRW2_DISPLAY_TAG
BEGIN
   ITEMID = 6293
   CM_TEXT = NULLP
   CM_FILL = NULLP
   CM_BORD = <<"Courier New">>
   PENWID = 0
   ADD_FLAGS = 0
   TEXTPAT = 0
   TEXTFORE = 0
   TEXTBACK = 0
   LINEPAT = 255
   LINEFORE = 0
   LINEBACK = 1
   FILLPAT = 0
   FILLFORE = 0
   FILLBACK = 1
   FONTFACE = 0
   FONTSIZE = 700
   FONTSTYLE = 0
   FONTWEIGHT = 5
   CHARSET = 31
   CHARWIDTH = 5
   BASELINE = 0
   KERNING = 1
   DASHSTYLE = 0
   CAPSTYLE = 0
   JOINSTYLE = 32
   BORDSTYLE = 0
   PERS_FLAGS = 0
   NULL_FLAGS = 0
END

DEFINE  SRW2_DISPLAY_TAG
BEGIN
   ITEMID = 6361
   CM_TEXT = NULLP
   CM_FILL = NULLP
   CM_BORD = <<"clean">>
   PENWID = 0
   ADD_FLAGS = 0
   TEXTPAT = 0
   TEXTFORE = 0
   TEXTBACK = 0
   LINEPAT = 255
   LINEFORE = 0
   LINEBACK = 1
   FILLPAT = 0
   FILLFORE = 0
   FILLBACK = 1
   FONTFACE = 0
   FONTSIZE = 900
   FONTSTYLE = 0
   FONTWEIGHT = 5
   CHARSET = 31
   CHARWIDTH = 5
   BASELINE = 0
   KERNING = 1
   DASHSTYLE = 0
   CAPSTYLE = 0
   JOINSTYLE = 32
   BORDSTYLE = 0
   PERS_FLAGS = 0
   NULL_FLAGS = 0
END

DEFINE  SRW2_DISPLAY_TAG
BEGIN
   ITEMID = 6937
   CM_TEXT = NULLP
   CM_FILL = NULLP
   CM_BORD = NULLP
   PENWID = 0
   ADD_FLAGS = 0
   TEXTPAT = 0
   TEXTFORE = 0
   TEXTBACK = 0
   LINEPAT = 255
   LINEFORE = 0
   LINEBACK = 1
   FILLPAT = 0
   FILLFORE = 0
   FILLBACK = 1
   FONTFACE = 0
   FONTSIZE = 0
   FONTSTYLE = 0
   FONTWEIGHT = 0
   CHARSET = 0
   CHARWIDTH = 0
   BASELINE = 0
   KERNING = 0
   DASHSTYLE = 0
   CAPSTYLE = 0
   JOINSTYLE = 32
   BORDSTYLE = 0
   PERS_FLAGS = 0
   NULL_FLAGS = 0
END

DEFINE  SRW2_DISPLAY_TAG
BEGIN
   ITEMID = 6938
   CM_TEXT = NULLP
   CM_FILL = NULLP
   CM_BORD = <<"clean">>
   PENWID = 0
   ADD_FLAGS = 0
   TEXTPAT = 0
   TEXTFORE = 0
   TEXTBACK = 0
   LINEPAT = 255
   LINEFORE = 0
   LINEBACK = 1
   FILLPAT = 0
   FILLFORE = 0
   FILLBACK = 1
   FONTFACE = 0
   FONTSIZE = 860
   FONTSTYLE = 0
   FONTWEIGHT = 5
   CHARSET = 31
   CHARWIDTH = 5
   BASELINE = 0
   KERNING = 1
   DASHSTYLE = 0
   CAPSTYLE = 0
   JOINSTYLE = 32
   BORDSTYLE = 0
   PERS_FLAGS = 0
   NULL_FLAGS = 0
END

DEFINE  SRW2_DISPLAY_TAG
BEGIN
   ITEMID = 6942
   CM_TEXT = NULLP
   CM_FILL = NULLP
   CM_BORD = <<"clean">>
   PENWID = 0
   ADD_FLAGS = 0
   TEXTPAT = 0
   TEXTFORE = 0
   TEXTBACK = 0
   LINEPAT = 0
   LINEFORE = 0
   LINEBACK = 0
   FILLPAT = 0
   FILLFORE = 0
   FILLBACK = 0
   FONTFACE = 0
   FONTSIZE = 860
   FONTSTYLE = 0
   FONTWEIGHT = 5
   CHARSET = 31
   CHARWIDTH = 5
   BASELINE = 0
   KERNING = 1
   DASHSTYLE = 0
   CAPSTYLE = 0
   JOINSTYLE = 0
   BORDSTYLE = 0
   PERS_FLAGS = 0
   NULL_FLAGS = 0
END

DEFINE  SRW2_DISPLAY_TAG
BEGIN
   ITEMID = 7183
   CM_TEXT = NULLP
   CM_FILL = NULLP
   CM_BORD = <<"clean">>
   PENWID = 0
   ADD_FLAGS = 0
   TEXTPAT = 0
   TEXTFORE = 0
   TEXTBACK = 0
   LINEPAT = 0
   LINEFORE = 0
   LINEBACK = 0
   FILLPAT = 0
   FILLFORE = 0
   FILLBACK = 0
   FONTFACE = 0
   FONTSIZE = 900
   FONTSTYLE = 0
   FONTWEIGHT = 5
   CHARSET = 31
   CHARWIDTH = 5
   BASELINE = 0
   KERNING = 1
   DASHSTYLE = 0
   CAPSTYLE = 0
   JOINSTYLE = 0
   BORDSTYLE = 0
   PERS_FLAGS = 0
   NULL_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 106
   ALIAS = <<"c_company">>
   EXPR = <<"gsb.name">>
   DESC_EXPR = <<"C_COMPANY">>
   SEL_ORDER = 1
   DATA_TYPE = 7
   WIDTH = 30
   SCALE = 0
   PRECISION = 0
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 475
   ALIAS = <<"c_organization_id">>
   EXPR = <<"fsp.inventory_organization_id">>
   DESC_EXPR = <<"C_ORGANIZATION_ID">>
   SEL_ORDER = 2
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 15
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 477
   ALIAS = <<"GL_CURRENCY">>
   EXPR = <<"gsb.currency_code">>
   DESC_EXPR = <<"GL_CURRENCY">>
   SEL_ORDER = 3
   DATA_TYPE = 7
   WIDTH = 15
   SCALE = 0
   PRECISION = 0
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 506
   ALIAS = <<"STRUCTURE_ACC">>
   EXPR = <<"gsb.chart_of_accounts_id">>
   DESC_EXPR = <<"STRUCTURE_ACC">>
   SEL_ORDER = 4
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 15
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 508
   ALIAS = <<"STRUCTURE_CAT">>
   EXPR = <<"mdv.structure_id">>
   DESC_EXPR = <<"STRUCTURE_CAT">>
   SEL_ORDER = 5
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 510
   ALIAS = <<"c_yes">>
   EXPR = <<"flo1.meaning">>
   DESC_EXPR = <<"C_YES">>
   SEL_ORDER = 7
   DATA_TYPE = 7
   WIDTH = 80
   SCALE = 0
   PRECISION = 0
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 512
   ALIAS = <<"c_no">>
   EXPR = <<"flo2.meaning">>
   DESC_EXPR = <<"C_NO">>
   SEL_ORDER = 8
   DATA_TYPE = 7
   WIDTH = 80
   SCALE = 0
   PRECISION = 0
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 541
   ALIAS = <<"c_category_set_id">>
   EXPR = <<"mdv.category_set_id">>
   DESC_EXPR = <<"C_CATEGORY_SET_ID">>
   SEL_ORDER = 6
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3131
   ALIAS = <<"Invoice_Num">>
   EXPR = <<"INVOICE_NUM">>
   DESC_EXPR = <<"INVOICE_NUM">>
   SEL_ORDER = 1
   DATA_TYPE = 7
   WIDTH = 50
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3133
   ALIAS = <<"Invoice_Date">>
   EXPR = <<"INVOICE_DATE">>
   DESC_EXPR = <<"INVOICE_DATE">>
   SEL_ORDER = 2
   DATA_TYPE = 2
   WIDTH = 9
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 12
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3137
   ALIAS = <<"Entry_Type">>
   EXPR = <<"ENTRY_TYPE">>
   DESC_EXPR = <<"ENTRY_TYPE">>
   SEL_ORDER = 3
   DATA_TYPE = 7
   WIDTH = 80
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3147
   ALIAS = <<"QTY_INVOICED">>
   EXPR = <<"QTY_INVOICED">>
   DESC_EXPR = <<"QTY_INVOICED">>
   SEL_ORDER = 8
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3149
   ALIAS = <<"Item_Description">>
   EXPR = <<"ITEM_DESCRIPTION">>
   DESC_EXPR = <<"ITEM_DESCRIPTION">>
   SEL_ORDER = 16
   DATA_TYPE = 7
   WIDTH = 240
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3151
   ALIAS = <<"Vendor">>
   EXPR = <<"VENDOR">>
   DESC_EXPR = <<"VENDOR">>
   SEL_ORDER = 17
   DATA_TYPE = 7
   WIDTH = 240
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3153
   ALIAS = <<"PO_Number_Release">>
   EXPR = <<"PO_NUMBER_RELEASE">>
   DESC_EXPR = <<"PO_NUMBER_RELEASE">>
   SEL_ORDER = 18
   DATA_TYPE = 7
   WIDTH = 23
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3155
   ALIAS = <<"Currency">>
   EXPR = <<"CURRENCY">>
   DESC_EXPR = <<"CURRENCY">>
   SEL_ORDER = 19
   DATA_TYPE = 7
   WIDTH = 15
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3157
   ALIAS = <<"Line_Num">>
   EXPR = <<"LINE_NUM">>
   DESC_EXPR = <<"LINE_NUM">>
   SEL_ORDER = 21
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3159
   ALIAS = <<"Unit">>
   EXPR = <<"UNIT">>
   DESC_EXPR = <<"UNIT">>
   SEL_ORDER = 22
   DATA_TYPE = 7
   WIDTH = 25
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3161
   ALIAS = <<"Location">>
   EXPR = <<"LOCATION">>
   DESC_EXPR = <<"LOCATION">>
   SEL_ORDER = 23
   DATA_TYPE = 7
   WIDTH = 60
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3163
   ALIAS = <<"Invoice_Base_Price">>
   EXPR = <<"INVOICE_BASE_PRICE">>
   DESC_EXPR = <<"INVOICE_BASE_PRICE">>
   SEL_ORDER = 24
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3165
   ALIAS = <<"PO_Base_Price">>
   EXPR = <<"PO_BASE_PRICE">>
   DESC_EXPR = <<"PO_BASE_PRICE">>
   SEL_ORDER = 25
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3319
   ALIAS = <<"C_FLEX_CAT">>
   EXPR = <<"C_FLEX_CAT">>
   DESC_EXPR = <<"C_FLEX_CAT">>
   SEL_ORDER = 4
   DATA_TYPE = 7
   WIDTH = 838
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 3448
   ALIAS = <<"C_FLEX_ITEM">>
   EXPR = <<"C_FLEX_ITEM">>
   DESC_EXPR = <<"C_FLEX_ITEM">>
   SEL_ORDER = 5
   DATA_TYPE = 7
   WIDTH = 838
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 4394
   ALIAS = <<"set_of_books">>
   EXPR = <<"fsp.set_of_books_id">>
   DESC_EXPR = <<"SET_OF_BOOKS">>
   SEL_ORDER = 11
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 15
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 4850
   ALIAS = <<"C_VAR_ACCT">>
   EXPR = <<"C_VAR_ACCT">>
   DESC_EXPR = <<"C_VAR_ACCT">>
   SEL_ORDER = 6
   DATA_TYPE = 7
   WIDTH = 207
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6636
   ALIAS = <<"c_precision">>
   EXPR = <<"fc.precision">>
   DESC_EXPR = <<"C_PRECISION">>
   SEL_ORDER = 9
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 1
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6858
   ALIAS = <<"c_ext_precision">>
   EXPR = <<"nvl(fc.extended_precision,fc.precision)">>
   DESC_EXPR = <<"C_EXT_PRECISION">>
   SEL_ORDER = 10
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 103
   ODATA_TYPE = 0
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6896
   ALIAS = <<"Invoice_currency">>
   EXPR = <<"INVOICE_CURRENCY">>
   DESC_EXPR = <<"INVOICE_CURRENCY">>
   SEL_ORDER = 20
   DATA_TYPE = 7
   WIDTH = 15
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6923
   ALIAS = <<"Invoice_rate">>
   EXPR = <<"INVOICE_RATE">>
   DESC_EXPR = <<"INVOICE_RATE">>
   SEL_ORDER = 9
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6926
   ALIAS = <<"Invoice_amount">>
   EXPR = <<"INVOICE_AMOUNT">>
   DESC_EXPR = <<"INVOICE_AMOUNT">>
   SEL_ORDER = 10
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6929
   ALIAS = <<"Invoice_price">>
   EXPR = <<"INVOICE_PRICE">>
   DESC_EXPR = <<"INVOICE_PRICE">>
   SEL_ORDER = 11
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 6935
   ALIAS = <<"Po_price">>
   EXPR = <<"PO_PRICE">>
   DESC_EXPR = <<"PO_PRICE">>
   SEL_ORDER = 13
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 7938
   ALIAS = <<"item_id">>
   EXPR = <<"ITEM_ID">>
   DESC_EXPR = <<"ITEM_ID">>
   SEL_ORDER = 15
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 7948
   ALIAS = <<"receipt_Unit">>
   EXPR = <<"RECEIPT_UNIT">>
   DESC_EXPR = <<"RECEIPT_UNIT">>
   SEL_ORDER = 14
   DATA_TYPE = 7
   WIDTH = 25
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 7968
   ALIAS = <<"ex_rate_vari">>
   EXPR = <<"EX_RATE_VARI">>
   DESC_EXPR = <<"EX_RATE_VARI">>
   SEL_ORDER = 27
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 7971
   ALIAS = <<"base_inv_price_var">>
   EXPR = <<"BASE_INV_PRICE_VAR">>
   DESC_EXPR = <<"BASE_INV_PRICE_VAR">>
   SEL_ORDER = 26
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8030
   ALIAS = <<"vendor_type">>
   EXPR = <<"VENDOR_TYPE">>
   DESC_EXPR = <<"VENDOR_TYPE">>
   SEL_ORDER = 29
   DATA_TYPE = 7
   WIDTH = 30
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8033
   ALIAS = <<"vendor_number">>
   EXPR = <<"VENDOR_NUMBER">>
   DESC_EXPR = <<"VENDOR_NUMBER">>
   SEL_ORDER = 30
   DATA_TYPE = 7
   WIDTH = 30
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8045
   ALIAS = <<"organization_id">>
   EXPR = <<"ORGANIZATION_ID">>
   DESC_EXPR = <<"ORGANIZATION_ID">>
   SEL_ORDER = 31
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8048
   ALIAS = <<"agent_id">>
   EXPR = <<"AGENT_ID">>
   DESC_EXPR = <<"AGENT_ID">>
   SEL_ORDER = 32
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 9
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8077
   ALIAS = <<"po_header_id">>
   EXPR = <<"PO_HEADER_ID">>
   DESC_EXPR = <<"PO_HEADER_ID">>
   SEL_ORDER = 34
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8080
   ALIAS = <<"po_line_id">>
   EXPR = <<"PO_LINE_ID">>
   DESC_EXPR = <<"PO_LINE_ID">>
   SEL_ORDER = 35
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8083
   ALIAS = <<"LINE_LOCATION_ID">>
   EXPR = <<"LINE_LOCATION_ID">>
   DESC_EXPR = <<"LINE_LOCATION_ID">>
   SEL_ORDER = 36
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8103
   ALIAS = <<"ship_to_location_id">>
   EXPR = <<"SHIP_TO_LOCATION_ID">>
   DESC_EXPR = <<"SHIP_TO_LOCATION_ID">>
   SEL_ORDER = 37
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8138
   ALIAS = <<"po_rate">>
   EXPR = <<"PO_RATE">>
   DESC_EXPR = <<"PO_RATE">>
   SEL_ORDER = 12
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 38
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8178
   ALIAS = <<"rcv_transaction_id">>
   EXPR = <<"RCV_TRANSACTION_ID">>
   DESC_EXPR = <<"RCV_TRANSACTION_ID">>
   SEL_ORDER = 38
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 15
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8231
   ALIAS = <<"C_VAR_ACCT_ERV">>
   EXPR = <<"C_VAR_ACCT_ERV">>
   DESC_EXPR = <<"C_VAR_ACCT_ERV">>
   SEL_ORDER = 7
   DATA_TYPE = 7
   WIDTH = 207
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8263
   ALIAS = <<"PO_DISTRIBUTION_ID">>
   EXPR = <<"PO_DISTRIBUTION_ID">>
   DESC_EXPR = <<"PO_DISTRIBUTION_ID">>
   SEL_ORDER = 33
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 15
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8273
   ALIAS = <<"pod_ccid">>
   EXPR = <<"POD_CCID">>
   DESC_EXPR = <<"POD_CCID">>
   SEL_ORDER = 28
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = -127
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8304
   ALIAS = <<"PRICE_HOLD_EXISTS">>
   EXPR = <<"PRICE_HOLD_EXISTS">>
   DESC_EXPR = <<"PRICE_HOLD_EXISTS">>
   SEL_ORDER = 40
   DATA_TYPE = 7
   WIDTH = 1
   SCALE = 0
   PRECISION = 0
   QUERYID = 3128
   ODATA_TYPE = 1
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ELEMENT
BEGIN
   ITEMID = 8325
   ALIAS = <<"INVOICE_ID">>
   EXPR = <<"INVOICE_ID">>
   DESC_EXPR = <<"INVOICE_ID">>
   SEL_ORDER = 39
   DATA_TYPE = 1
   WIDTH = 22
   SCALE = 0
   PRECISION = 15
   QUERYID = 3128
   ODATA_TYPE = 2
   RELOPLST = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_GROUP
BEGIN
   ITEMID = 104
   NAME = <<"G_company">>
   TAG = 0
   DISP_ORDER = 10
   PTAG = 0
   QUERY_ID = 103
   PARENT_ID = 0
   QLF_TYPE = 0
   QLF_ARG = 0
   QLF_COLUMN = 0
   GLF_TYPE = 0
   GLF_ARG = 0
   GLF_COLUMN = 0
   RLF_TYPE = 0
   RLF_ARG = 0
   RLF_COLUMN = 0
   CROSS_PROD = 0
   PRODUCT_ID = 0
   NUM_POINTS = 0
   POINTS = (BINARY) NULLP
   X = 3687
   Y = 18432
   WD = 12288
   HT = 18928
   DFLT_DIR = 1
   PERS_FLAGS = 0
   MAIL_TEXT = NULLP
   XML_TAG = <<"G_COMPANY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   OUTER_XML_TAG = <<"LIST_G_COMPANY">>
   OUTER_ATTR = NULLP
END

DEFINE  SRW2_GROUP
BEGIN
   ITEMID = 3129
   NAME = <<"G_Catgeory">>
   TAG = 0
   DISP_ORDER = 4
   PTAG = 0
   QUERY_ID = 3128
   PARENT_ID = 0
   QLF_TYPE = 0
   QLF_ARG = 0
   QLF_COLUMN = 0
   GLF_TYPE = 0
   GLF_ARG = 0
   GLF_COLUMN = 0
   RLF_TYPE = 0
   RLF_ARG = 0
   RLF_COLUMN = 0
   CROSS_PROD = 0
   PRODUCT_ID = 0
   NUM_POINTS = 0
   POINTS = (BINARY) NULLP
   X = 24167
   Y = 13739
   WD = 12288
   HT = 13328
   DFLT_DIR = 1
   PERS_FLAGS = 0
   MAIL_TEXT = NULLP
   XML_TAG = <<"G_CATGEORY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   OUTER_XML_TAG = <<"LIST_G_CATGEORY">>
   OUTER_ATTR = NULLP
END

DEFINE  SRW2_GROUP
BEGIN
   ITEMID = 3222
   NAME = <<"G_Item">>
   TAG = 0
   DISP_ORDER = 5
   PTAG = 0
   QUERY_ID = 3128
   PARENT_ID = 3129
   QLF_TYPE = 0
   QLF_ARG = 0
   QLF_COLUMN = 0
   GLF_TYPE = 0
   GLF_ARG = 0
   GLF_COLUMN = 0
   RLF_TYPE = 0
   RLF_ARG = 0
   RLF_COLUMN = 0
   CROSS_PROD = 0
   PRODUCT_ID = 0
   NUM_POINTS = 0
   POINTS = (BINARY) NULLP
   X = 24167
   Y = 28672
   WD = 12288
   HT = 11928
   DFLT_DIR = 32769
   PERS_FLAGS = 0
   MAIL_TEXT = NULLP
   XML_TAG = <<"G_ITEM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   OUTER_XML_TAG = <<"LIST_G_ITEM">>
   OUTER_ATTR = NULLP
END

DEFINE  SRW2_GROUP
BEGIN
   ITEMID = 3223
   NAME = <<"G_Vendors">>
   TAG = 0
   DISP_ORDER = 6
   PTAG = 0
   QUERY_ID = 3128
   PARENT_ID = 3222
   QLF_TYPE = 0
   QLF_ARG = 0
   QLF_COLUMN = 0
   GLF_TYPE = 0
   GLF_ARG = 0
   GLF_COLUMN = 0
   RLF_TYPE = 0
   RLF_ARG = 0
   RLF_COLUMN = 0
   CROSS_PROD = 0
   PRODUCT_ID = 0
   NUM_POINTS = 0
   POINTS = (BINARY) NULLP
   X = 41319
   Y = 9643
   WD = 12288
   HT = 10528
   DFLT_DIR = 32769
   PERS_FLAGS = 0
   MAIL_TEXT = NULLP
   XML_TAG = <<"G_VENDORS">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   OUTER_XML_TAG = <<"LIST_G_VENDORS">>
   OUTER_ATTR = NULLP
END

DEFINE  SRW2_GROUP
BEGIN
   ITEMID = 3224
   NAME = <<"G_Pos">>
   TAG = 0
   DISP_ORDER = 7
   PTAG = 0
   QUERY_ID = 3128
   PARENT_ID = 3223
   QLF_TYPE = 0
   QLF_ARG = 0
   QLF_COLUMN = 0
   GLF_TYPE = 0
   GLF_ARG = 0
   GLF_COLUMN = 0
   RLF_TYPE = 0
   RLF_ARG = 0
   RLF_COLUMN = 0
   CROSS_PROD = 0
   PRODUCT_ID = 0
   NUM_POINTS = 0
   POINTS = (BINARY) NULLP
   X = 41575
   Y = 22220
   WD = 12288
   HT = 18928
   DFLT_DIR = 32769
   PERS_FLAGS = 0
   MAIL_TEXT = NULLP
   XML_TAG = <<"G_POS">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   OUTER_XML_TAG = <<"LIST_G_POS">>
   OUTER_ATTR = NULLP
END

DEFINE  SRW2_GROUP
BEGIN
   ITEMID = 6717
   NAME = <<"G_Invoices">>
   TAG = 0
   DISP_ORDER = 8
   PTAG = 0
   QUERY_ID = 3128
   PARENT_ID = 3224
   QLF_TYPE = 0
   QLF_ARG = 0
   QLF_COLUMN = 0
   GLF_TYPE = 0
   GLF_ARG = 0
   GLF_COLUMN = 0
   RLF_TYPE = 0
   RLF_ARG = 0
   RLF_COLUMN = 0
   CROSS_PROD = 0
   PRODUCT_ID = 0
   NUM_POINTS = 0
   POINTS = (BINARY) NULLP
   X = 58795
   Y = 9807
   WD = 17047
   HT = 41328
   DFLT_DIR = 32769
   PERS_FLAGS = 0
   MAIL_TEXT = NULLP
   XML_TAG = <<"G_INVOICES">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   OUTER_XML_TAG = <<"LIST_G_INVOICES">>
   OUTER_ATTR = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 89
   NAME = <<"PRINTJOB">>
   TAG = 0
   DISP_ORDER = 52
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"Yes">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 128
   PRECISION = 0
   SCALE = 0
   X = 8192
   Y = 8192
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PRINTJOB">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 90
   NAME = <<"MODE">>
   TAG = 0
   DISP_ORDER = 51
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"Default">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 128
   PRECISION = 0
   SCALE = 0
   X = 6144
   Y = 6144
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"MODE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 91
   NAME = <<"BACKGROUND">>
   TAG = 0
   DISP_ORDER = 50
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"No">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 128
   PRECISION = 0
   SCALE = 0
   X = 4096
   Y = 4096
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"BACKGROUND">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 92
   NAME = <<"ORIENTATION">>
   TAG = 0
   DISP_ORDER = 49
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"Default">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 128
   PRECISION = 0
   SCALE = 0
   X = 2048
   Y = 2048
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ORIENTATION">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 93
   NAME = <<"DECIMAL">>
   TAG = 0
   DISP_ORDER = 38
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 1
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 181033
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Decimal">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"DECIMAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 94
   NAME = <<"THOUSANDS">>
   TAG = 0
   DISP_ORDER = 37
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 1
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 159735
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Thousands">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"THOUSANDS">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 95
   NAME = <<"CURRENCY">>
   TAG = 0
   DISP_ORDER = 36
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 4
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 149086
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Currency">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CURRENCY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 96
   NAME = <<"COPIES">>
   TAG = 0
   DISP_ORDER = 35
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"1">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 4
   FLAGS = 0
   PRECISION = 2
   SCALE = 0
   X = 138437
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Copies">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"COPIES">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 97
   NAME = <<"DESFORMAT">>
   TAG = 0
   DISP_ORDER = 34
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"dflt">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 1024
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 117139
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Desformat">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"DESFORMAT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 98
   NAME = <<"DESNAME">>
   TAG = 0
   DISP_ORDER = 33
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 1024
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 95841
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Desname">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"DESNAME">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 99
   NAME = <<"DESTYPE">>
   TAG = 0
   DISP_ORDER = 32
   GROUP_ID = 1
   SOURCE = 2
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"Screen">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 85192
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Destype">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"DESTYPE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 105
   NAME = <<"c_company">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 106
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 30
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Name">>
   DFLT_WID = 300000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_COMPANY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 107
   NAME = <<"company">>
   TAG = 0
   DISP_ORDER = 11
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 105
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 30
   FLAGS = 40
   PRECISION = 0
   SCALE = 0
   X = 32317
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Company">>
   DFLT_WID = 300000
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"COMPANY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 113
   NAME = <<"P_title">>
   TAG = 0
   DISP_ORDER = 39
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 50
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 202331
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Title">>
   DFLT_WID = 0
   DEREF_ID = 75
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_TITLE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 474
   NAME = <<"c_organization_id">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 475
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 15
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C Organization Id">>
   DFLT_WID = 170000
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_ORGANIZATION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 476
   NAME = <<"GL_CURRENCY">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 477
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 15
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Gl Currency">>
   DFLT_WID = 150000
   DEREF_ID = 22
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"GL_CURRENCY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 505
   NAME = <<"STRUCTURE_ACC">>
   TAG = 0
   DISP_ORDER = 3
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 506
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 15
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Structure Acc">>
   DFLT_WID = 170000
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"STRUCTURE_ACC">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 507
   NAME = <<"STRUCTURE_CAT">>
   TAG = 0
   DISP_ORDER = 4
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 508
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Structure Cat">>
   DFLT_WID = 400000
   DEREF_ID = 63
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"STRUCTURE_CAT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 509
   NAME = <<"c_yes">>
   TAG = 0
   DISP_ORDER = 5
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 510
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C Yes">>
   DFLT_WID = 800000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_YES">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 511
   NAME = <<"c_no">>
   TAG = 0
   DISP_ORDER = 6
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 512
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C No">>
   DFLT_WID = 800000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_NO">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 540
   NAME = <<"c_category_set_id">>
   TAG = 0
   DISP_ORDER = 7
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 541
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C Category Set Id">>
   DFLT_WID = 400000
   DEREF_ID = 61
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_CATEGORY_SET_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 542
   NAME = <<"organization_id">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 474
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 17
   FLAGS = 40
   PRECISION = 15
   SCALE = 0
   X = 9557
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Organization Id">>
   DFLT_WID = 170000
   DEREF_ID = 60
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ORGANIZATION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 543
   NAME = <<"category_set_id">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 540
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 40
   PRECISION = 38
   SCALE = 0
   X = 43176
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Category Set Id">>
   DFLT_WID = 400000
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CATEGORY_SET_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 544
   NAME = <<"yes">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 509
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 40
   PRECISION = 0
   SCALE = 0
   X = 21298
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"Yes">>
   DFLT_WID = 800000
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"YES">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 545
   NAME = <<"no">>
   TAG = 0
   DISP_ORDER = 12
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 511
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 40
   PRECISION = 0
   SCALE = 0
   X = 53921
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"No">>
   DFLT_WID = 800000
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"NO">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 546
   NAME = <<"P_CONC_REQUEST_ID">>
   TAG = 0
   DISP_ORDER = 40
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"0">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 15
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Conc Request Id">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_CONC_REQUEST_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 549
   NAME = <<"P_VENDOR_FROM">>
   TAG = 0
   DISP_ORDER = 28
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 240
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 21298
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Vendor From">>
   DFLT_WID = 0
   DEREF_ID = 66
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_VENDOR_FROM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 550
   NAME = <<"P_VENDOR_TO">>
   TAG = 0
   DISP_ORDER = 29
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 240
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 42596
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Vendor To">>
   DFLT_WID = 0
   DEREF_ID = 67
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_VENDOR_TO">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 720
   NAME = <<"P_FLEX_CAT">>
   TAG = 0
   DISP_ORDER = 43
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"(MCA.SEGMENT1||'\n'||MCA.SEGMENT2||'\n'||MCA.SEGMENT3||'\n'||MCA.SEGMENT4||'\n'||MCA.SEGMENT5||'\n'||MCA.SEGMENT6||'\n'||MCA.SEGMENT7||'\n'||MCA.SEGMENT8||'\n'||MCA.SEGMENT9||'\n'||MCA.SEGMENT10||'\n'||MCA.SEGMENT11||'\n'||MCA.SEGMENT12||'\n'||MCA.SEGMENT13||'\n'||MCA.SEGMENT14||'\n'||MCA.SEGMENT15||'\n'||MCA.SEGMENT16||'\n'||MCA.SEGMENT17||'\n'||MCA.SEGMENT18||'\n'||MCA.SEGMENT19||'\n'||MCA.SEGMENT20)">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 31000
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 31947
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Flex Cat">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_FLEX_CAT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 721
   NAME = <<"P_FLEX_ITEM">>
   TAG = 0
   DISP_ORDER = 45
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"(MSI.SEGMENT1||'\n'||MSI.SEGMENT2||'\n'||MSI.SEGMENT3||'\n'||MSI.SEGMENT4||'\n'||MSI.SEGMENT5||'\n'||MSI.SEGMENT6||'\n'||MSI.SEGMENT7||'\n'||MSI.SEGMENT8||'\n'||MSI.SEGMENT9||'\n'||MSI.SEGMENT10||'\n'||MSI.SEGMENT11||'\n'||MSI.SEGMENT12||'\n'||MSI.SEGMENT13||'\n'||MSI.SEGMENT14||'\n'||MSI.SEGMENT15||'\n'||MSI.SEGMENT16||'\n'||MSI.SEGMENT17||'\n'||MSI.SEGMENT18||'\n'||MSI.SEGMENT19||'\n'||MSI.SEGMENT20)">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 31000
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 53245
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Flex Item">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_FLEX_ITEM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 1171
   NAME = <<"P_DESTINATION_TYPE">>
   TAG = 0
   DISP_ORDER = 46
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 85192
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Destination Type">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_DESTINATION_TYPE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3104
   NAME = <<"P_qty_precision">>
   TAG = 0
   DISP_ORDER = 47
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"0">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 127788
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Qty Precision">>
   DFLT_WID = 0
   DEREF_ID = 5
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_QTY_PRECISION">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3130
   NAME = <<"Invoice_Num">>
   TAG = 0
   DISP_ORDER = 24
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 3131
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 50
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 71
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_NUM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3132
   NAME = <<"Invoice_Date">>
   TAG = 0
   DISP_ORDER = 26
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 3133
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 2
   FILE_TYPE = 1
   WIDTH = 9
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 12
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_DATE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3136
   NAME = <<"Entry_Type">>
   TAG = 0
   DISP_ORDER = 27
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 3137
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 80
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ENTRY_TYPE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3146
   NAME = <<"QTY_INVOICED">>
   TAG = 0
   DISP_ORDER = 28
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 3147
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 32
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 20
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"QTY_INVOICED">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3148
   NAME = <<"Item_Description">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 3222
   SOURCE = 0
   SOURCE_ID = 3149
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 240
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ITEM_DESCRIPTION">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3150
   NAME = <<"Vendor">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 3223
   SOURCE = 0
   SOURCE_ID = 3151
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 240
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3152
   NAME = <<"PO_Number_Release">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 3153
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 23
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_NUMBER_RELEASE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3154
   NAME = <<"Currency1">>
   TAG = 0
   DISP_ORDER = 3
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 3155
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 15
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CURRENCY1">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3156
   NAME = <<"Line_Num">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 3157
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"LINE_NUM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3158
   NAME = <<"Unit">>
   TAG = 0
   DISP_ORDER = 7
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 3159
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 25
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 52
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"UNIT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3160
   NAME = <<"Location">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 3161
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 60
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"LOCATION">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3162
   NAME = <<"Invoice_Base_Price">>
   TAG = 0
   DISP_ORDER = 31
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 3163
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 32
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 6
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_BASE_PRICE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3164
   NAME = <<"PO_Base_Price">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 3165
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 32
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 7
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_BASE_PRICE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3187
   NAME = <<"count_records">>
   TAG = 0
   DISP_ORDER = 13
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 3148
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 6
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 10
   FLAGS = 40
   PRECISION = 8
   SCALE = 0
   X = 79145
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 1
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"COUNT_RECORDS">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3188
   NAME = <<"C_Charge_ACCT_Disp">>
   TAG = 0
   DISP_ORDER = 34
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 900
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 13
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_CHARGE_ACCT_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3190
   NAME = <<"C_Variance_ACCT_Disp">>
   TAG = 0
   DISP_ORDER = 36
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 900
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 15
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_VARIANCE_ACCT_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3214
   NAME = <<"Inv_Price_Variance">>
   TAG = 0
   DISP_ORDER = 32
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 48
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 28
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INV_PRICE_VARIANCE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3216
   NAME = <<"Vendor_IPV_Total">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 3223
   SOURCE = 1
   SOURCE_ID = 3214
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 3223
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 40
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 26
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR_IPV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3218
   NAME = <<"C_FLEX_CAT_DISP">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 3129
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 900
   FLAGS = 16
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C Flex Cat Disp">>
   DFLT_WID = 100000
   DEREF_ID = 9
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_FLEX_CAT_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3220
   NAME = <<"C_FLEX_ITEM_DISP">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 3222
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 900
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 11
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_FLEX_ITEM_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3225
   NAME = <<"Item_IPV_Total">>
   TAG = 0
   DISP_ORDER = 3
   GROUP_ID = 3222
   SOURCE = 1
   SOURCE_ID = 3214
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 3222
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 40
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 24
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ITEM_IPV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3226
   NAME = <<"Category_IPV_Total">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 3129
   SOURCE = 1
   SOURCE_ID = 3214
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 3129
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 8
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Category Ipv Total">>
   DFLT_WID = 90000
   DEREF_ID = 21
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CATEGORY_IPV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3229
   NAME = <<"P_WHERE_CAT">>
   TAG = 0
   DISP_ORDER = 44
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"1=1">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 31000
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 42596
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Where Cat">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_WHERE_CAT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3230
   NAME = <<"P_CATEGORY_FROM">>
   TAG = 0
   DISP_ORDER = 41
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 900
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 10649
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Category From">>
   DFLT_WID = 0
   DEREF_ID = 64
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_CATEGORY_FROM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3231
   NAME = <<"P_CATEGORY_TO">>
   TAG = 0
   DISP_ORDER = 42
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 900
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 21298
   Y = 3276
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Category To">>
   DFLT_WID = 0
   DEREF_ID = 65
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_CATEGORY_TO">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3233
   NAME = <<"P_SET_OF_BOOKS_ID">>
   TAG = 0
   DISP_ORDER = 30
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"2">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 53245
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Set Of Books Id">>
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_SET_OF_BOOKS_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3234
   NAME = <<"P_PERIOD_NAME">>
   TAG = 0
   DISP_ORDER = 27
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = <<"P Period Name">>
   DFLT_WID = 0
   DEREF_ID = 62
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_PERIOD_NAME">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3318
   NAME = <<"C_FLEX_CAT">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 3129
   SOURCE = 0
   SOURCE_ID = 3319
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 838
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C Flex Cat">>
   DFLT_WID = 100000
   DEREF_ID = 8
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_FLEX_CAT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3356
   NAME = <<"P_STRUCT_NUM">>
   TAG = 0
   DISP_ORDER = 31
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = <<"101">>
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 74543
   Y = 0
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 16
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_STRUCT_NUM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 3447
   NAME = <<"C_FLEX_ITEM">>
   TAG = 0
   DISP_ORDER = 0
   GROUP_ID = 3222
   SOURCE = 0
   SOURCE_ID = 3448
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 838
   FLAGS = 33
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 10
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_FLEX_ITEM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 4393
   NAME = <<"set_of_books">>
   TAG = 0
   DISP_ORDER = 8
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 4394
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 15
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 80
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"SET_OF_BOOKS">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 4643
   NAME = <<"STRUCTURE_ACC1">>
   TAG = 0
   DISP_ORDER = 14
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 505
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 17
   FLAGS = 40
   PRECISION = 15
   SCALE = 0
   X = 21864
   Y = 4252
   WD = 10650
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"STRUCTURE_ACC1">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 4719
   NAME = <<"P_chart_of_accounts_id">>
   TAG = 0
   DISP_ORDER = 48
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = <<"50105">>
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 32
   PRECISION = 10
   SCALE = 0
   X = 164
   Y = 6881
   WD = 11141
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 17
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_CHART_OF_ACCOUNTS_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 4849
   NAME = <<"C_VAR_ACCT">>
   TAG = 0
   DISP_ORDER = 37
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 4850
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 207
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 18
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_VAR_ACCT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6461
   NAME = <<"Category_IPV_TOTAL_DISP">>
   TAG = 0
   DISP_ORDER = 3
   GROUP_ID = 3129
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 19
   FLAGS = 16
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Category Ipv Total Disp">>
   DFLT_WID = 100000
   DEREF_ID = 23
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CATEGORY_IPV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6463
   NAME = <<"Item_IPV_total_disp">>
   TAG = 0
   DISP_ORDER = 4
   GROUP_ID = 3222
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 19
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 25
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ITEM_IPV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6465
   NAME = <<"Vendor_ipv_total_disp">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 3223
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 19
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 27
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR_IPV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6467
   NAME = <<"INV_PRICE_VARIANCE_DISP">>
   TAG = 0
   DISP_ORDER = 33
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 19
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 29
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INV_PRICE_VARIANCE_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6473
   NAME = <<"Report_IPV_TOTAL">>
   TAG = 0
   DISP_ORDER = 15
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 3214
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 40
   PRECISION = 38
   SCALE = 0
   X = 32602
   Y = 4162
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 30
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"REPORT_IPV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6475
   NAME = <<"Report_IPV_TOTAL_DISP">>
   TAG = 0
   DISP_ORDER = 16
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 19
   FLAGS = 48
   PRECISION = 0
   SCALE = 0
   X = 43336
   Y = 4164
   WD = 12745
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 31
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"REPORT_IPV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6561
   NAME = <<"C_CURRENCY">>
   TAG = 0
   DISP_ORDER = 17
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 476
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 7
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 15
   FLAGS = 40
   PRECISION = 0
   SCALE = 0
   X = 78899
   Y = 4048
   WD = 10649
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 32
   ODATA_TYPE = 96
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_CURRENCY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6635
   NAME = <<"c_precision">>
   TAG = 0
   DISP_ORDER = 9
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 6636
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 1
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 33
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_PRECISION">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6857
   NAME = <<"c_ext_precision">>
   TAG = 0
   DISP_ORDER = 10
   GROUP_ID = 104
   SOURCE = 0
   SOURCE_ID = 6858
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 33
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 34
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_EXT_PRECISION">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6869
   NAME = <<"qty_invoiced_print">>
   TAG = 0
   DISP_ORDER = 29
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 48
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"QTY_INVOICED_PRINT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6873
   NAME = <<"Invoice_base_price_round">>
   TAG = 0
   DISP_ORDER = 30
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 48
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_BASE_PRICE_ROUND">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6895
   NAME = <<"Invoice_currency">>
   TAG = 0
   DISP_ORDER = 4
   GROUP_ID = 3129
   SOURCE = 0
   SOURCE_ID = 6896
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 15
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Invoice Currency">>
   DFLT_WID = 100000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_CURRENCY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6922
   NAME = <<"Invoice_rate">>
   TAG = 0
   DISP_ORDER = 17
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 6923
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Invoice Rate">>
   DFLT_WID = 20000
   DEREF_ID = 40
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_RATE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6925
   NAME = <<"Invoice_amount">>
   TAG = 0
   DISP_ORDER = 20
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 6926
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Invoice Amount">>
   DFLT_WID = 20000
   DEREF_ID = 39
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_AMOUNT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6928
   NAME = <<"Invoice_price">>
   TAG = 0
   DISP_ORDER = 21
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 6929
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Invoice Price">>
   DFLT_WID = 20000
   DEREF_ID = 38
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_PRICE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6934
   NAME = <<"Po_price">>
   TAG = 0
   DISP_ORDER = 23
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 6935
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Po Price">>
   DFLT_WID = 20000
   DEREF_ID = 37
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_PRICE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6948
   NAME = <<"Exch_rate_variance">>
   TAG = 0
   DISP_ORDER = 41
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 20
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 42
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"EXCH_RATE_VARIANCE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6950
   NAME = <<"exch_rate_variance_disp">>
   TAG = 0
   DISP_ORDER = 40
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 16
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 43
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"EXCH_RATE_VARIANCE_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6952
   NAME = <<"Vendor_ERV_Total_Disp">>
   TAG = 0
   DISP_ORDER = 3
   GROUP_ID = 3223
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 16
   FLAGS = 16
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 45
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR_ERV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6953
   NAME = <<"Vendor_ERV_Total">>
   TAG = 0
   DISP_ORDER = 4
   GROUP_ID = 3223
   SOURCE = 1
   SOURCE_ID = 6948
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 3223
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 8
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 44
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR_ERV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6955
   NAME = <<"Item_ERV_Total">>
   TAG = 0
   DISP_ORDER = 5
   GROUP_ID = 3222
   SOURCE = 1
   SOURCE_ID = 6948
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 3222
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 8
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 46
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ITEM_ERV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6956
   NAME = <<"Item_ERV_total_Disp">>
   TAG = 0
   DISP_ORDER = 6
   GROUP_ID = 3222
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 16
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 47
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ITEM_ERV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6958
   NAME = <<"Category_ERV_total">>
   TAG = 0
   DISP_ORDER = 5
   GROUP_ID = 3129
   SOURCE = 1
   SOURCE_ID = 6948
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 3129
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 8
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Category Erv Total">>
   DFLT_WID = 90000
   DEREF_ID = 48
   ODATA_TYPE = 0
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CATEGORY_ERV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6959
   NAME = <<"Category_ERV_Total_Disp">>
   TAG = 0
   DISP_ORDER = 6
   GROUP_ID = 3129
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 16
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Category Erv Total Disp">>
   DFLT_WID = 100000
   DEREF_ID = 49
   ODATA_TYPE = 0
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CATEGORY_ERV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6961
   NAME = <<"Report_ERV_total">>
   TAG = 0
   DISP_ORDER = 18
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 6948
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 1
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 40
   FLAGS = 8
   PRECISION = 38
   SCALE = 0
   X = 55996
   Y = 4163
   WD = 9236
   HT = 3277
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 50
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"REPORT_ERV_TOTAL">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 6962
   NAME = <<"Report_ERV_Total_Disp">>
   TAG = 0
   DISP_ORDER = 19
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 16
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 65212
   Y = 4164
   WD = 11136
   HT = 3276
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 51
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"REPORT_ERV_TOTAL_DISP">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 7937
   NAME = <<"item_id">>
   TAG = 0
   DISP_ORDER = 16
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 7938
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Item Id">>
   DFLT_WID = 20000
   DEREF_ID = 54
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ITEM_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 7947
   NAME = <<"receipt_Unit">>
   TAG = 0
   DISP_ORDER = 15
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 7948
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 25
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Receipt Unit">>
   DFLT_WID = 100000
   DEREF_ID = 53
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"RECEIPT_UNIT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 7967
   NAME = <<"ex_rate_vari">>
   TAG = 0
   DISP_ORDER = 13
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 7968
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Ex Rate Vari">>
   DFLT_WID = 20000
   DEREF_ID = 57
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"EX_RATE_VARI">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 7970
   NAME = <<"base_inv_price_var">>
   TAG = 0
   DISP_ORDER = 14
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 7971
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Base Inv Price Var">>
   DFLT_WID = 20000
   DEREF_ID = 56
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"BASE_INV_PRICE_VAR">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8029
   NAME = <<"vendor_type">>
   TAG = 0
   DISP_ORDER = 8
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8030
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 30
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Vendor Type">>
   DFLT_WID = 100000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR_TYPE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8032
   NAME = <<"vendor_number">>
   TAG = 0
   DISP_ORDER = 7
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8033
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 30
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Vendor Number">>
   DFLT_WID = 100000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"VENDOR_NUMBER">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8042
   NAME = <<"CF_PRODUCT_LINE">>
   TAG = 0
   DISP_ORDER = 39
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 78
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_PRODUCT_LINE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8044
   NAME = <<"organization_id1">>
   TAG = 0
   DISP_ORDER = 12
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8045
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Organization Id1">>
   DFLT_WID = 20000
   DEREF_ID = 58
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"ORGANIZATION_ID1">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8047
   NAME = <<"agent_id">>
   TAG = 0
   DISP_ORDER = 11
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8048
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 9
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Agent Id">>
   DFLT_WID = 110000
   DEREF_ID = 59
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"AGENT_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8050
   NAME = <<"CF_BUYER">>
   TAG = 0
   DISP_ORDER = 18
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_BUYER">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8052
   NAME = <<"CF_CATEGORY_CODE">>
   TAG = 0
   DISP_ORDER = 35
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_CATEGORY_CODE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8054
   NAME = <<"CF_PERIOD_NAME">>
   TAG = 0
   DISP_ORDER = 20
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 81682
   Y = 10240
   WD = 14165
   HT = 1638
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_PERIOD_NAME">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8058
   NAME = <<"CF_CATEGORY_FROM">>
   TAG = 0
   DISP_ORDER = 21
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 81767
   Y = 16042
   WD = 14165
   HT = 1638
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_CATEGORY_FROM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8060
   NAME = <<"CF_CATEGORY_TO">>
   TAG = 0
   DISP_ORDER = 22
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 20
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 81852
   Y = 18944
   WD = 14080
   HT = 1638
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_CATEGORY_TO">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8062
   NAME = <<"CF_VENDOR_FROM">>
   TAG = 0
   DISP_ORDER = 23
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 82023
   Y = 21845
   WD = 14080
   HT = 1638
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_VENDOR_FROM">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8064
   NAME = <<"CF_VENDOR_TO">>
   TAG = 0
   DISP_ORDER = 24
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 81938
   Y = 24576
   WD = 14336
   HT = 1877
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_VENDOR_TO">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8076
   NAME = <<"po_header_id">>
   TAG = 0
   DISP_ORDER = 8
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 8077
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Po Header Id">>
   DFLT_WID = 20000
   DEREF_ID = 69
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_HEADER_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8079
   NAME = <<"po_line_id">>
   TAG = 0
   DISP_ORDER = 4
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 8080
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Po Line Id">>
   DFLT_WID = 20000
   DEREF_ID = 72
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_LINE_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8082
   NAME = <<"LINE_LOCATION_ID">>
   TAG = 0
   DISP_ORDER = 6
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 8083
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Line Location Id">>
   DFLT_WID = 20000
   DEREF_ID = 70
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"LINE_LOCATION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8085
   NAME = <<"CF_INV_FUNCT_AMOUNT">>
   TAG = 0
   DISP_ORDER = 19
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 102
   FLAGS = 16
   PRECISION = 100
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_INV_FUNCT_AMOUNT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8100
   NAME = <<"CF_TITLE">>
   TAG = 0
   DISP_ORDER = 25
   GROUP_ID = 1
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 200
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 81938
   Y = 12970
   WD = 13909
   HT = 1792
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_TITLE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8102
   NAME = <<"ship_to_location_id">>
   TAG = 0
   DISP_ORDER = 5
   GROUP_ID = 3224
   SOURCE = 0
   SOURCE_ID = 8103
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Ship To Location Id">>
   DFLT_WID = 20000
   DEREF_ID = 76
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"SHIP_TO_LOCATION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8112
   NAME = <<"CF_ORGANIZATION_ID">>
   TAG = 0
   DISP_ORDER = 10
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 20
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 77
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_ORGANIZATION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8137
   NAME = <<"po_rate">>
   TAG = 0
   DISP_ORDER = 9
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8138
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 38
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Po Rate">>
   DFLT_WID = 90000
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_RATE">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8177
   NAME = <<"rcv_transaction_id">>
   TAG = 0
   DISP_ORDER = 6
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8178
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 15
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Rcv Transaction Id">>
   DFLT_WID = 90000
   DEREF_ID = 79
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"RCV_TRANSACTION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8230
   NAME = <<"C_VAR_ACCT_ERV">>
   TAG = 0
   DISP_ORDER = 38
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8231
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 207
   FLAGS = 0
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"C Var Acct Erv">>
   DFLT_WID = 100000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"C_VAR_ACCT_ERV">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8257
   NAME = <<"CF_CHARGE_ACC">>
   TAG = 0
   DISP_ORDER = 22
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 20
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_CHARGE_ACC">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 1
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8261
   NAME = <<"CP_CHARGE_ACT">>
   TAG = 0
   DISP_ORDER = 25
   GROUP_ID = 6717
   SOURCE = 4
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 1000
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 82
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CP_CHARGE_ACT">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8262
   NAME = <<"PO_DISTRIBUTION_ID">>
   TAG = 0
   DISP_ORDER = 5
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8263
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 15
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Po Distribution Id1">>
   DFLT_WID = 20000
   DEREF_ID = 0
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PO_DISTRIBUTION_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8272
   NAME = <<"pod_ccid">>
   TAG = 0
   DISP_ORDER = 4
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8273
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 0
   PRECISION = 0
   SCALE = -127
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Pod Ccid">>
   DFLT_WID = 20000
   DEREF_ID = 84
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"POD_CCID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8303
   NAME = <<"PRICE_HOLD_EXISTS">>
   TAG = 0
   DISP_ORDER = 3
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8304
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 7
   FILE_TYPE = 1
   WIDTH = 1
   FLAGS = 1
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Price Hold Exists">>
   DFLT_WID = 10000
   DEREF_ID = 0
   ODATA_TYPE = 1
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"PRICE_HOLD_EXISTS">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8322
   NAME = <<"CF_PRICE_HOLD_RELEASED_BY">>
   TAG = 0
   DISP_ORDER = 2
   GROUP_ID = 6717
   SOURCE = 1
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 240
   FLAGS = 16
   PRECISION = 10
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 0
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"CF_PRICE_HOLD_RELEASED_BY">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8324
   NAME = <<"INVOICE_ID">>
   TAG = 0
   DISP_ORDER = 1
   GROUP_ID = 6717
   SOURCE = 0
   SOURCE_ID = 8325
   COMPUTE_ID = 1
   PROD_ORDER = NULLP
   RESET_ID = 1
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 1
   FILE_TYPE = 1
   WIDTH = 22
   FLAGS = 1
   PRECISION = 15
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = <<"Invoice Id">>
   DFLT_WID = 90000
   DEREF_ID = 85
   ODATA_TYPE = 2
   DFLT_HGT = 10000
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"INVOICE_ID">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_COLUMN
BEGIN
   ITEMID = 8370
   NAME = <<"p_where_vendor_name">>
   TAG = 0
   DISP_ORDER = 53
   GROUP_ID = 1
   SOURCE = 3
   SOURCE_ID = 0
   COMPUTE_ID = 0
   PROD_ORDER = NULLP
   RESET_ID = 0
   NULL_VALUE = NULLP
   INPUT_MASK = NULLP
   OPERATOR = 0
   DATA_TYPE = 0
   FILE_TYPE = 1
   WIDTH = 240
   FLAGS = 32
   PRECISION = 0
   SCALE = 0
   X = 0
   Y = 0
   WD = 0
   HT = 0
   DFLT_LBL = NULLP
   DFLT_WID = 0
   DEREF_ID = 86
   ODATA_TYPE = 0
   DFLT_HGT = 0
   PARA_TYPE = 0
   PLOV_RTYPE = 0
   PLOV_SLISTID = 0
   PLOV_SELECT = NULLP
   PLOV_COL = NULLP
   REFDTYPE = 0
   PERS_FLAGS = 0
   EXPANDED = 0
   SUBGROUP = 0
   TYPENAME = NULLP
   SCHEMA = NULLP
   PARENT_COL = 0
   BOUND = 0
   SORTSRCCOL = 0
   SORTCOL = 0
   XML_TAG = <<"P_WHERE_VENDOR_NAME">>
   XML_ATTR = NULLP
   XML_SUPPRESS = 0
   CONTAIN_XML = 0
   RTYPE = 0
   PDSCLS = NULLP
END

DEFINE  SRW2_LINK
BEGIN
   ITEMID = 4184
   TAG = 0
   DISP_ORDER = 26
   PARENT_ID = 104
   P_COLUMN = 0
   CHILD_ID = 3129
   C_COLUMN = 0
   CLAUSE = 1
   OPERATOR = 2
   NUM_POINTS = 32
   POINTS = (BINARY)
<<"
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
">>
   PERS_FLAGS = 0
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 116
   SEG_ORDER = 0
   TAG = 6942
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 121
   SEG_ORDER = 0
   TAG = 6942
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 153
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 155
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 780
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 785
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 787
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 1430
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 1432
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 1440
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 2045
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 2870
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 2872
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 3041
   SEG_ORDER = 0
   TAG = 6942
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 3057
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 3210
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 3365
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 3366
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 3369
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 5389
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 5390
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6367
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6371
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6478
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6483
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6729
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6810
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6812
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6813
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6814
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6815
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6818
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6820
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6821
   SEG_ORDER = 0
   TAG = 6942
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6823
   SEG_ORDER = 0
   TAG = 6942
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6824
   SEG_ORDER = 0
   TAG = 6942
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6825
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6826
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6827
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6828
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6829
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6830
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6831
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6832
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6833
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6834
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6835
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6836
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6837
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6839
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6840
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6841
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6842
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6843
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6844
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6845
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6846
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6847
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6848
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6849
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6849
   SEG_ORDER = 1
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6850
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6850
   SEG_ORDER = 1
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6851
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6852
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6853
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6854
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6855
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6940
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6940
   SEG_ORDER = 1
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6943
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6966
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6973
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6975
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6977
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_TEXT_SEGMENT
BEGIN
   ITEMID = 6980
   SEG_ORDER = 0
   TAG = 7183
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 776
   NAME = <<"M_Category_GRPFR">>
   TAG = 6937
   DISP_ORDER = 0
   FORMATFLAG = 1879048460
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 0
   WD = 64944
   HT = 32768
   PAGE = 0
   GROUP_ID = 728
   CONTINUED = 0
   DIRECTION = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 0
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 16
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 778
   NAME = <<"R_Category">>
   TAG = 6937
   DISP_ORDER = 1
   FORMATFLAG = 1879048460
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 0
   WD = 64944
   HT = 32768
   PAGE = 0
   GROUP_ID = 3129
   CONTINUED = 0
   DIRECTION = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 1666
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 781
   NAME = <<"M_Item_GRPFR">>
   TAG = 6937
   DISP_ORDER = 2
   FORMATFLAG = 1879048460
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 1365
   WD = 64944
   HT = 28672
   PAGE = 0
   GROUP_ID = 729
   CONTINUED = 0
   DIRECTION = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 0
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 783
   NAME = <<"R_Item">>
   TAG = 6937
   DISP_ORDER = 3
   FORMATFLAG = 1879048460
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 1365
   WD = 64944
   HT = 28672
   PAGE = 0
   GROUP_ID = 3222
   CONTINUED = 0
   DIRECTION = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 1666
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 788
   NAME = <<"M_Vendor_GRPFR">>
   TAG = 6937
   DISP_ORDER = 4
   FORMATFLAG = 1879048460
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 6827
   WD = 64944
   HT = 20480
   PAGE = 0
   GROUP_ID = 548
   CONTINUED = 0
   DIRECTION = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 0
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 789
   NAME = <<"M_Vendor_HDR">>
   TAG = 6937
   DISP_ORDER = 5
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 6827
   WD = 64944
   HT = 12288
   PAGE = 0
   GROUP_ID = 548
   CONTINUED = 0
   DIRECTION = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 0
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 790
   NAME = <<"R_Vendor">>
   TAG = 6937
   DISP_ORDER = 6
   FORMATFLAG = 1879048460
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 19115
   WD = 64944
   HT = 8192
   PAGE = 0
   GROUP_ID = 3223
   CONTINUED = 0
   DIRECTION = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 1666
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 1975
   NAME = <<"R_pos">>
   TAG = 6937
   DISP_ORDER = 8
   FORMATFLAG = 536871180
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 984
   Y = 20480
   WD = 63960
   HT = 4096
   PAGE = 0
   GROUP_ID = 3224
   CONTINUED = 0
   DIRECTION = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 1666
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 1976
   NAME = <<"R_Invoices">>
   TAG = 6937
   DISP_ORDER = 9
   FORMATFLAG = 536871180
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 4428
   Y = 21845
   WD = 60516
   HT = 2731
   PAGE = 0
   GROUP_ID = 6717
   CONTINUED = 0
   DIRECTION = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 0
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FRAME
BEGIN
   ITEMID = 6884
   NAME = <<"M_account">>
   TAG = 6937
   DISP_ORDER = 61
   FORMATFLAG = 536871180
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 6686
   Y = 23211
   WD = 56290
   HT = 1365
   PAGE = 0
   GROUP_ID = 0
   CONTINUED = 0
   DIRECTION = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   BETWEEN_X = 0
   BETWEEN_Y = 0
   RESERVED = 0
   BIDI_DIR = 0
   MAX_COLS = 0
   MAX_ROWS = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   FRAME_TYPE = 0
   TEMPL_ID = 0
   TABCAP = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 112
   NAME = <<"F_company">>
   TAG = 6938
   DISP_ORDER = 91
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 492
   Y = 0
   WD = 14760
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 107
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 115
   NAME = <<"F_report_date">>
   TAG = 6938
   DISP_ORDER = 92
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 56580
   Y = 0
   WD = 8364
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = <<"DD-MON-YYYY HH24:MI">>
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 119
   NAME = <<"F_current_page">>
   TAG = 6938
   DISP_ORDER = 96
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 58056
   Y = 1365
   WD = 1968
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 12
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 120
   NAME = <<"F_total_pages">>
   TAG = 6938
   DISP_ORDER = 97
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 62976
   Y = 1365
   WD = 1968
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 15
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 149
   NAME = <<"F_h_company">>
   TAG = 6361
   DISP_ORDER = 112
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 0
   WD = 14760
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 107
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 152
   NAME = <<"F_h_report_date">>
   TAG = 6361
   DISP_ORDER = 113
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 56580
   Y = 0
   WD = 8364
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = <<"DD-MON-YYYY HH24:MI">>
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3167
   NAME = <<"F_CATEGORY_DISP">>
   TAG = 6361
   DISP_ORDER = 19
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 10332
   Y = 0
   WD = 11316
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3218
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3169
   NAME = <<"F_ITEM_DISP">>
   TAG = 6361
   DISP_ORDER = 20
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 10332
   Y = 1365
   WD = 11316
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3220
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3170
   NAME = <<"F_Item_Description">>
   TAG = 6361
   DISP_ORDER = 21
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 10332
   Y = 2731
   WD = 21648
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3148
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3192
   NAME = <<"F_Vendor">>
   TAG = 6361
   DISP_ORDER = 48
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 19115
   WD = 19680
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3150
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3193
   NAME = <<"F_PO_RELEASE_NUM">>
   TAG = 6361
   DISP_ORDER = 49
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 984
   Y = 20480
   WD = 9840
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3152
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3194
   NAME = <<"F_Line_num">>
   TAG = 6361
   DISP_ORDER = 50
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 11316
   Y = 20480
   WD = 1968
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3156
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3195
   NAME = <<"F_Ship_to_location">>
   TAG = 6361
   DISP_ORDER = 51
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 13776
   Y = 20480
   WD = 12300
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3160
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3196
   NAME = <<"F_Currency">>
   TAG = 6361
   DISP_ORDER = 52
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 26568
   Y = 20480
   WD = 3936
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3154
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3197
   NAME = <<"F_Unit">>
   TAG = 6361
   DISP_ORDER = 53
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 30996
   Y = 20480
   WD = 3444
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3158
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3198
   NAME = <<"F_Inv_Number">>
   TAG = 6361
   DISP_ORDER = 54
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 4428
   Y = 21845
   WD = 6888
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3130
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3199
   NAME = <<"F_Inv_Date">>
   TAG = 6361
   DISP_ORDER = 55
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 11808
   Y = 21845
   WD = 5904
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3132
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3200
   NAME = <<"F_Entry_Type">>
   TAG = 6361
   DISP_ORDER = 56
   FORMATFLAG = 536871180
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 18204
   Y = 21845
   WD = 4920
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3136
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3201
   NAME = <<"F_Qty_Invoiced">>
   TAG = 6361
   DISP_ORDER = 57
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 23616
   Y = 21845
   WD = 7380
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6869
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3203
   NAME = <<"F_Invoice_price">>
   TAG = 6361
   DISP_ORDER = 58
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 31488
   Y = 21845
   WD = 8364
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6873
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3204
   NAME = <<"F_PO_Base_price">>
   TAG = 6361
   DISP_ORDER = 59
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 40344
   Y = 21845
   WD = 6888
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3164
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3205
   NAME = <<"F_Inv_Price_variance">>
   TAG = 6361
   DISP_ORDER = 60
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 21845
   WD = 7652
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6467
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3206
   NAME = <<"F_Variance_Acct">>
   TAG = 6361
   DISP_ORDER = 62
   FORMATFLAG = 536871180
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 26568
   Y = 23211
   WD = 17220
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3190
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3207
   NAME = <<"F_Charge_Acct">>
   TAG = 6361
   DISP_ORDER = 63
   FORMATFLAG = 536871180
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 8856
   Y = 23211
   WD = 17220
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3188
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3208
   NAME = <<"F_Vendor_IPV_Total">>
   TAG = 6361
   DISP_ORDER = 64
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 25941
   WD = 7652
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6465
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3211
   NAME = <<"F_Item_IPV_Total">>
   TAG = 6361
   DISP_ORDER = 66
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 28672
   WD = 7652
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6463
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3212
   NAME = <<"F_category_ipv_total">>
   TAG = 6361
   DISP_ORDER = 67
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 31403
   WD = 7652
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6461
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3367
   NAME = <<"F_period_name">>
   TAG = 6361
   DISP_ORDER = 106
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 22632
   Y = 13653
   WD = 10332
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3234
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3368
   NAME = <<"F_vendor_from">>
   TAG = 6361
   DISP_ORDER = 107
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 22632
   Y = 10923
   WD = 19680
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 549
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3370
   NAME = <<"F_vendor_to_title">>
   TAG = 6361
   DISP_ORDER = 102
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 22632
   Y = 12288
   WD = 19680
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 550
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3371
   NAME = <<"F_cat_from_title">>
   TAG = 6361
   DISP_ORDER = 103
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 22632
   Y = 8192
   WD = 19680
   HT = 1365
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3230
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 3372
   NAME = <<"F_cat_to_title">>
   TAG = 6361
   DISP_ORDER = 104
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 22632
   Y = 9557
   WD = 19680
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 3231
   CONTINUED = 0
   ALIGNMENT = 4
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6368
   NAME = <<"F_total_pages1">>
   TAG = 6361
   DISP_ORDER = 119
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 62976
   Y = 1365
   WD = 1968
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 15
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6370
   NAME = <<"F_current_page1">>
   TAG = 6361
   DISP_ORDER = 118
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 58056
   Y = 1365
   WD = 1968
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 12
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6451
   NAME = <<"F_H_TITLE">>
   TAG = 6361
   DISP_ORDER = 121
   FORMATFLAG = 872415488
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 19680
   Y = 1365
   WD = 25584
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 113
   CONTINUED = 0
   ALIGNMENT = 68
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6454
   NAME = <<"F_TITLE">>
   TAG = 6938
   DISP_ORDER = 100
   FORMATFLAG = 805339392
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 19680
   Y = 1365
   WD = 25584
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 113
   CONTINUED = 0
   ALIGNMENT = 68
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6480
   NAME = <<"F_report_ipv_total">>
   TAG = 6361
   DISP_ORDER = 74
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 34133
   WD = 7652
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6475
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6946
   NAME = <<"F_Exch_Rate_Variance">>
   TAG = 6361
   DISP_ORDER = 81
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 21845
   WD = 7340
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6950
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6968
   NAME = <<"F_Vendor_ERV_Total">>
   TAG = 6361
   DISP_ORDER = 82
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57567
   Y = 25941
   WD = 7340
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6952
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6971
   NAME = <<"F_Item_ERV_Total">>
   TAG = 6361
   DISP_ORDER = 84
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57567
   Y = 28671
   WD = 7340
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6956
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6974
   NAME = <<"F_Category_ERV_Total">>
   TAG = 6361
   DISP_ORDER = 85
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 31402
   WD = 7340
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6959
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_FIELD
BEGIN
   ITEMID = 6976
   NAME = <<"F_report_erv_total">>
   TAG = 6361
   DISP_ORDER = 88
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 34133
   WD = 7340
   HT = 1366
   PAGE = 0
   PGN_FLAGS = 7
   PGN_START = 1
   PGN_INCR = 1
   PGN_RESET = 1
   SOURCE_ID = 6962
   CONTINUED = 0
   ALIGNMENT = 36
   TEXT_WRAP = 1
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   MASK = NULLP
   NULL_VALUE = NULLP
   SPACING = 0
   BIDI_DIR = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
END

DEFINE  SRW2_ANCHOR
BEGIN
   ITEMID = 5184
   TAG = 0
   DISP_ORDER = 68
   HEAD_ID = 3212
   HEAD_EDGE = 3
   HEAD_PCT = 1
   TAIL_ID = 1440
   TAIL_EDGE = 3
   TAIL_PCT = 100
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c158 00007aab 00002c34 00007aab 
">>
   COLLAPSE = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ANCHOR
BEGIN
   ITEMID = 5185
   TAG = 0
   DISP_ORDER = 69
   HEAD_ID = 3211
   HEAD_EDGE = 3
   HEAD_PCT = 1
   TAIL_ID = 1432
   TAIL_EDGE = 3
   TAIL_PCT = 100
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c158 00007000 0000285c 00007000 
">>
   COLLAPSE = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ANCHOR
BEGIN
   ITEMID = 5188
   TAG = 0
   DISP_ORDER = 70
   HEAD_ID = 3208
   HEAD_EDGE = 3
   HEAD_PCT = 1
   TAIL_ID = 2045
   TAIL_EDGE = 3
   TAIL_PCT = 100
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c158 00006555 00001ec0 00006555 
">>
   COLLAPSE = 0
   PERS_FLAGS = 0
END

DEFINE  SRW2_ANCHOR
BEGIN
   ITEMID = 6484
   TAG = 0
   DISP_ORDER = 76
   HEAD_ID = 6480
   HEAD_EDGE = 3
   HEAD_PCT = 0
   TAIL_ID = 6483
   TAIL_EDGE = 3
   TAIL_PCT = 100
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c10c 00008555 00002c34 00008555 
">>
   COLLAPSE = 0
   PERS_FLAGS = 0
END

DEFINE  TOOL_COMMENT
BEGIN
   ITEMID = 4391
   OBJECT_ID = 0
   CMTLFID_T = (TLONG)
<<"$Header: POXRCIPV.rdf 120.4.12010000.2 2009/08/14 22:35  lswamina noship                                                                                                                                                                                                                                                      $
/*======================================================================+
|  Copyright (c) 1994 Oracle Corporation    Redwood Shores, CA.  USA    |
|                        All rights reserved.                           |
|                        Oracle Manufacturing                           |
+=======================================================================+
/*
DATE                VERSION  UPDATED BY    TASK#                         COMMENTS

08-MAR-2022    1.26             U104764           PTASK0000320          Performance Issue fixed 



*/">>
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 722
   NAME = <<"beforereport">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 0
   TYPE = 7
   PLSLFID_ST = (TLONG)
<<"function BeforeReport return boolean is
begin


begin

  --  SRW.USER_EXIT('FND SRWINIT');
    -- Bug 6127034. Moved the call to USER_EXIT function to  AFTER PARAMETER FORM trigger. 
  if (get_p_struct_num != TRUE )
    then SRW.MESSAGE('1','Init failed');
  end if;                                                                    
  if (get_chart_of_accounts_id != TRUE )
  then SRW.MESSAGE('2','Init failed');
  end if;                                                                     

  SRW.USER_EXIT('FND FLEXSQL CODE           ="MCAT" 
                             OUTPUT         =":P_FLEX_CAT"
                             APPL_SHORT_NAME="INV"
                             MODE           ="SELECT" 
                             DISPLAY        ="ALL" 
                             MULTINUM       ="YES"
                             TABLEALIAS     ="MCA"');

  SRW.USER_EXIT('FND FLEXSQL CODE           ="MSTK" 
                             OUTPUT         =":P_FLEX_ITEM"
                             APPL_SHORT_NAME="INV"
                             MODE           ="SELECT" 
                             DISPLAY        ="ALL" 
                             NUM            ="101"
                             TABLEALIAS     ="MSI"');

 /* SRW.USER_EXIT('FND FLEXSQL CODE           ="GL#"
                             OUTPUT         =":P_FLEX_CHARGE_ACCT"
                             APPL_SHORT_NAME="SQLGL"
                             MODE           ="SELECT"
                             DISPLAY        ="ALL"
--                             MULTINUM       ="YES"
                             NUM            =":P_chart_of_accounts_id"
                             TABLEALIAS     ="GCC"');


  SRW.USER_EXIT('FND FLEXSQL CODE           ="GL#"
                             OUTPUT         =":P_FLEX_VAR_ACCT"
                             APPL_SHORT_NAME="SQLGL"         
                             MODE           ="SELECT"    
                             DISPLAY        ="ALL"  
--                             MULTINUM       ="YES"   
                             NUM            =":P_chart_of_accounts_id"
                             TABLEALIAS     ="GCC1"');*/ 

   SRW.USER_EXIT('FND  FLEXSQL CODE          ="MCAT" 
                             OUTPUT         =":P_WHERE_CAT" 
                             APPL_SHORT_NAME="INV"   
                             MODE           ="WHERE"  
                             DISPLAY        ="ALL"  
                             NUM            =":P_STRUCT_NUM"   
                             TABLEALIAS     ="MCA"        
                             OPERATOR       ="BETWEEN" 
                             OPERAND1       =":P_CATEGORY_FROM" 
                             OPERAND2       =":P_CATEGORY_TO"');   

    -- RT9001090 start
   IF :p_vendor_from IS NOT NULL AND :p_vendor_to IS NOT NULL
   		THEN 
   				SRW.MESSAGE(10001,'Before Report:p_where_vendor_name');
   					:p_where_vendor_name := ' AND NVL(pov.vendor_name, ''A'') BETWEEN  NVL( ''' || :p_vendor_from || 
       ''' , NVL(pov.vendor_name, ''A'')) AND NVL(''' || :p_vendor_to ||
       ''' , NVL(pov.vendor_name, ''A''))';
       SRW.MESSAGE(10001,'before report:p_where_vendor_name:'||:p_where_vendor_name);
   END IF;
   -- RT9001090 end            

  RETURN TRUE;
END;  return (TRUE);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 1431
   NAME = <<"b_nodata_foundformattrigger">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 1430
   TYPE = 5
   PLSLFID_ST = (TLONG)
<<"function B_nodata_foundFormatTrigger return boolean is
begin

return(:count_records = 0);  return (TRUE);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3103
   NAME = <<"get_precision">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 0
   TYPE = 0
   PLSLFID_ST = (TLONG)
<<"
/* Created by Cam Larner   15-MAR-93       */
/* Dynamic Format Mask for Quantity Fields */

procedure get_precision is
begin
srw.attr.mask        :=  SRW.FORMATMASK_ATTR;
if :P_qty_precision = 0 then srw.attr.formatmask  := '-NNN,NNN,NNN,NN0';
else
if :P_qty_precision = 1 then srw.attr.formatmask  := '-NNN,NNN,NNN,NN0.0';
else
if :P_qty_precision = 3 then srw.attr.formatmask  :=  '-NN,NNN,NNN,NN0.000';
else
if :P_qty_precision = 4 then srw.attr.formatmask  :=   '-N,NNN,NNN,NN0.0000';
else
if :P_qty_precision = 5 then srw.attr.formatmask  :=     '-NNN,NNN,NN0.00000';
else
if :P_qty_precision = 6 then srw.attr.formatmask  :=      '-NN,NNN,NN0.000000';
else srw.attr.formatmask  :=  '-NNN,NNN,NNN,NN0.00';
end if; end if; end if; end if; end if; end if;
srw.set_attr(0,srw.attr);
end;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3189
   NAME = <<"c_charge_acct_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 3188
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function C_Charge_ACCT_DispFormula return VARCHAR2 is
begin

/*SRW.REFERENCE(:C_CHARGE_ACCT);
SRW.USER_EXIT('FND FLEXIDVAL CODE              ="GL#"
                             APPL_SHORT_NAME   ="SQLGL"
                             DATA              =":C_CHARGE_ACCT"
                             VALUE             =":C_CHARGE_ACCT_DISP"
                             DISPLAY           ="ALL"
                             NUM               =":P_chart_of_accounts_id"');
                             
                             
*/

RETURN (:CP_CHARGE_ACT);
/*
return('aaaaa');
*/
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3191
   NAME = <<"c_variance_acct_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 3190
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function C_Variance_ACCT_DispFormula return VARCHAR2 is
begin

/*SRW.REFERENCE(:C_VAR_ACCT);
SRW.USER_EXIT('FND FLEXIDVAL CODE                ="GL#"
                             APPL_SHORT_NAME     ="SQLGL"
                             DATA                =":C_VAR_ACCT"
                             VALUE               =":C_VARIANCE_ACCT_DISP"
                             DISPLAY             ="ALL"
                             NUM                 =":P_chart_of_accounts_id"');
RETURN(:C_VARIANCE_ACCT_DISP);*/
/*
return('bbbb');
*/
return (:C_VAR_ACCT);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3202
   NAME = <<"f_qty_invoicedformattrigger">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 3201
   TYPE = 5
   PLSLFID_ST = (TLONG)
<<"function F_Qty_InvoicedFormatTrigger return boolean is
begin

get_precision;  return (TRUE);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3215
   NAME = <<"inv_price_variance">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 3214
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function inv_price_variance return number is

begin
/*
 
 if ((:qty_invoiced is null) OR (:qty_invoiced = 0))then
    return (round(:invoice_base_price_raw, :c_ext_precision));

  else 
   
   return round((:QTY_INVOICED * (:Invoice_base_price_raw - :PO_Base_Uom_price)), :c_ext_precision) ;

 end if;  
Bug 3038604
We do not need to calculate the variance. We can directly pick it from the ap_invoice_distributions table */

  return (round(:base_inv_price_var,:c_ext_precision));  --bug 5142653  
   
RETURN NULL; 
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3219
   NAME = <<"c_flex_cat_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 3218
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function C_FLEX_CAT_DISPFormula return VARCHAR2 is
begin

SRW.REFERENCE(:C_FLEX_CAT);
SRW.USER_EXIT('FND FLEXIDVAL CODE              ="MCAT"
                             APPL_SHORT_NAME   ="INV"
                             DATA              =":C_FLEX_CAT"
                             VALUE             =":C_FLEX_CAT_DISP"
                             DISPLAY           ="ALL"
                             NUM               =":P_STRUCT_NUM"');
RETURN(:C_FLEX_CAT_DISP);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3221
   NAME = <<"c_flex_item_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 3220
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function C_FLEX_ITEM_DISPFormula return VARCHAR2 is
begin

SRW.REFERENCE(:C_FLEX_ITEM);
SRW.USER_EXIT('FND FLEXIDVAL CODE             ="MSTK"
                           APPL_SHORT_NAME  ="INV"
                           DATA             =":C_FLEX_ITEM"
                           VALUE            =":C_FLEX_ITEM_DISP"
                           DISPLAY          ="ALL"
                           NUM              ="101"');
RETURN(:C_FLEX_ITEM_DISP);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 3228
   NAME = <<"afterreport">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 0
   TYPE = 8
   PLSLFID_ST = (TLONG)
<<"function AfterReport return boolean is
begin

SRW.USER_EXIT('FND SRWEXIT');  return (TRUE);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 5052
   NAME = <<"get_p_struct_num">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 0
   TYPE = 0
   PLSLFID_ST = (TLONG)
<<"function get_p_struct_num return boolean is

l_p_struct_num number;

begin
        select structure_id 
        into l_p_struct_num
        from mtl_default_sets_view 
        where functional_area_id = 2 ;

        :P_STRUCT_NUM := l_p_struct_num ; 

        return(TRUE) ; 

        RETURN NULL; exception
        when others then return(FALSE) ; 
end;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 5053
   NAME = <<"get_chart_of_accounts_id">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 0
   TYPE = 0
   PLSLFID_ST = (TLONG)
<<"function get_chart_of_accounts_id return boolean is

l_chart_of_accounts_id number;
l_set_of_books_id financials_system_parameters.set_of_books_id%TYPE;
l_period_start_date gl_period_statuses.start_date%TYPE;
l_period_end_date   gl_period_statuses.end_date %TYPE;
begin
        select gsob.chart_of_accounts_id,fsp.set_of_books_id 
        into l_chart_of_accounts_id,l_set_of_books_id
        from gl_sets_of_books gsob,
        financials_system_parameters fsp 
        where  fsp.set_of_books_id = gsob.set_of_books_id ;

        :P_CHART_OF_ACCOUNTS_ID := l_chart_of_accounts_id ; 
        
        -- RT9001090 start
        SRW.MESSAGE(10001,'get_chart_of_accounts_id:l_set_of_books_id:'||l_set_of_books_id);
        
        SELECT glps.start_date,glps.end_date 
        INTO l_period_start_date,l_period_end_date
        FROM gl_period_statuses glps
        WHERE glps.application_id = 201
              AND glps.set_of_books_id = l_set_of_books_id
              AND glps.period_name = :p_period_name
              ;
        SRW.MESSAGE(10001,'get_chart_of_accounts_id:l_period_start_date:'||l_period_start_date);
        SRW.MESSAGE(10001,'get_chart_of_accounts_id:l_period_end_date:'||l_period_end_date);
              
        xxcst1741_ctx_api.set_from_date(l_period_start_date);
        xxcst1741_ctx_api.set_to_date(l_period_end_date); 
        
        SRW.MESSAGE(10001,'get_chart_of_accounts_id:XXCST1741_CTX set');     
        -- RT9001090 end

        return(TRUE) ; 

        RETURN NULL; exception
        when others then return(FALSE) ; 
end;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6462
   NAME = <<"cat_ipv_disp">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6461
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"FUNCTION CAT_IPV_DISP RETURN CHARACTER IS
BEGIN
SRW.REFERENCE(:Category_IPV_total);
SRW.REFERENCE(:GL_CURRENCY);
SRW.USER_EXIT('FND FORMAT_CURRENCY
                   CODE=":GL_CURRENCY"
                   DISPLAY_WIDTH="16"
                   AMOUNT=":Category_IPV_total"
                   DISPLAY=":Category_IPV_total_DISP"');
RETURN(:Category_IPV_TOTAL_DISP);
END;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6464
   NAME = <<"item_ipv_disp">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6463
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"FUNCTION ITEM_IPV_DISP RETURN CHARACTER IS
BEGIN
SRW.REFERENCE(:Item_IPV_total);
SRW.REFERENCE(:GL_CURRENCY);
SRW.USER_EXIT('FND FORMAT_CURRENCY
                   CODE=":GL_CURRENCY"
                   DISPLAY_WIDTH="16"
                   AMOUNT=":Item_IPV_total"
                   DISPLAY=":Item_IPV_total_DISP"');
RETURN(:Item_IPV_TOTAL_DISP);
END;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6466
   NAME = <<"vendor_ipv_disp">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6465
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"FUNCTION VENDOR_IPV_DISP RETURN CHARACTER IS
BEGIN
SRW.REFERENCE(:Vendor_IPV_total);
SRW.REFERENCE(:GL_CURRENCY);
SRW.USER_EXIT('FND FORMAT_CURRENCY
                   CODE=":GL_CURRENCY"
                   DISPLAY_WIDTH="16"
                   AMOUNT=":Vendor_IPV_total"
                   DISPLAY=":Vendor_IPV_total_DISP"');
RETURN(:Vendor_IPV_TOTAL_DISP);
END;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6468
   NAME = <<"ipv_disp">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6467
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"FUNCTION IPV_DISP RETURN CHARACTER IS
BEGIN
SRW.REFERENCE(:Inv_Price_Variance);
SRW.REFERENCE(:GL_CURRENCY);
SRW.USER_EXIT('FND FORMAT_CURRENCY
                   CODE=":GL_CURRENCY"
                   DISPLAY_WIDTH="16"
                   AMOUNT=":Inv_Price_Variance"
                   DISPLAY=":Inv_Price_Variance_DISP"');
RETURN(:Inv_Price_Variance_DISP) ; 

end ; ">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6476
   NAME = <<"report_ipv_disp">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6475
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"FUNCTION REPORT_IPV_DISP RETURN CHARACTER IS
BEGIN
SRW.REFERENCE(:Report_IPV_total);
SRW.REFERENCE(:C_CURRENCY);
SRW.USER_EXIT('FND FORMAT_CURRENCY
                   CODE=":C_CURRENCY"
                   DISPLAY_WIDTH="16"
                   AMOUNT=":Report_IPV_total"
                   DISPLAY=":Report_IPV_total_DISP"');
RETURN(:Report_IPV_TOTAL_DISP);
END;
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6870
   NAME = <<"qty_inv_print">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6869
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function qty_inv_print return number is
begin

 if (:qty_invoiced is null) then
   return(0);
 
 else 
   return(:qty_invoiced);
 
 end if;
RETURN NULL; end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6874
   NAME = <<"inv_base_price_round">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6873
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function inv_base_price_round return number is
begin

 srw.reference(:c_ext_precision);
 srw.reference(:Invoice_base_price);

 return (round(:Invoice_base_price, :c_ext_precision));

end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6949
   NAME = <<"exch_rate_varianceformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6948
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function Exch_rate_varianceFormula return Number is
  ln_qty_invoiced number;
begin
/*  if (:po_price <> :invoice_price) then
     if (((:qty_invoiced is null) or (:qty_invoiced = 0))
	 and ((:invoice_price is not null) and (:invoice_price <> 0))) then
        ln_qty_invoiced:=round((:invoice_amount/:invoice_price),20);
 	return(round((ln_qty_invoiced * (:invoice_rate - :po_rate) *
	 :po_price),:c_ext_precision));
     else
	return(round((:qty_invoiced * (:invoice_rate - :po_rate) *
	 :po_price),:c_ext_precision));
     end if;
  else
     return(:inv_price_variance);
  end if; 
Bug 3038604
We do not need to calculate the variance. We can directly pick it from the ap_invoice_distributions table */
	return :ex_rate_vari;
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6951
   NAME = <<"exch_rate_variance_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6950
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function exch_rate_variance_dispFormula return Char is
begin
  srw.reference(:exch_rate_variance);
  srw.reference(:GL_CURRENCY);
  srw.user_exit('FND FORMAT_CURRENCY
		 CODE=":GL_CURRENCY"
		 DISPLAY_WIDTH="16"
		 AMOUNT=":EXCH_RATE_VARIANCE"
		 DISPLAY=":EXCH_RATE_VARIANCE_DISP"');
  return(:exch_rate_variance_disp);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6954
   NAME = <<"vendor_erv_total_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6952
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function Vendor_ERV_Total_DispFormula return Char is
begin
  srw.reference(:vendor_erv_total);
  srw.reference(:GL_CURRENCY);
  srw.user_exit('FND FORMAT_CURRENCY
		 CODE=":GL_CURRENCY"
		 DISPLAY_WIDTH="16"
		 AMOUNT=":vendor_erv_total"
		 DISPLAY=":VENDOR_ERV_TOTAL_DISP"');
  return(:vendor_erv_total_disp);
 
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6957
   NAME = <<"item_erv_total_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6956
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function Item_ERV_total_DispFormula return Char is
begin
  srw.reference(:item_erv_total);
  srw.reference(:GL_CURRENCY);
  srw.user_exit('FND FORMAT_CURRENCY
		 CODE=":GL_CURRENCY"
		 DISPLAY_WIDTH="16"
		 AMOUNT=":item_erv_total"
		 DISPLAY=":item_erv_total_DISP"');
  return(:item_erv_total_disp);
  
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6960
   NAME = <<"category_erv_total_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6959
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function Category_ERV_Total_DispFormula return Char is
begin
  srw.reference(:category_erv_total);
  srw.reference(:GL_CURRENCY);
  srw.user_exit('FND FORMAT_CURRENCY
		 CODE=":GL_CURRENCY"
		 DISPLAY_WIDTH="16"
		 AMOUNT=":category_erv_total"
		 DISPLAY=":category_erv_total_DISP"');
  return(:category_erv_total_disp);
  
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 6963
   NAME = <<"report_erv_total_dispformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 6962
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function Report_ERV_Total_DispFormula return Char is
begin
  srw.reference(:report_erv_total);
  srw.reference(:C_CURRENCY);
  srw.user_exit('FND FORMAT_CURRENCY
		 CODE=":C_CURRENCY"
		 DISPLAY_WIDTH="16"
		 AMOUNT=":report_erv_total"
		 DISPLAY=":report_erv_total_DISP"');
  return(:report_erv_total_disp);
  
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 7987
   NAME = <<"afterpform">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 0
   TYPE = 11
   PLSLFID_ST = (TLONG)
<<"function AfterPForm return boolean is
begin
  SRW.USER_EXIT('FND SRWINIT');    -- Bug 6127034.
  return (TRUE);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8043
   NAME = <<"cf_product_lineformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8042
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_PRODUCT_LINEFormula return Char is
l_product_code varchar2(100);
l_inventory_item_id number;
l_organization_id number;
begin
	  srw.message(1421,'item_id :'||:item_id);
	  srw.message(1422,'organization_id1 :'||:CF_ORGANIZATION_ID);
  select mtc.CATEGORY_CONCAT_SEGS
    into l_product_code
    from MTL_ITEM_CATEGORIES_V mtc,mtl_category_sets mcs
   where mtc.inventory_item_id = :item_id
     and  mcs.category_set_id  = mtc.category_set_id
     and mtc.category_set_name = 'XX_CST_PRODUCT_LINE'
     and mtc.organization_id   = :CF_ORGANIZATION_ID; 
     srw.message(1423,'CF_PRODUCT_LINE :'||l_product_code);
   return(l_product_code);  
exception
	when others then
	srw.message(1424,'When others exception at CF_PRODUCT_LINE :'||sqlerrm);
	return(null);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8051
   NAME = <<"cf_buyerformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8050
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_BUYERFormula return Char is
l_buyer varchar2(100);
begin
	select SUBSTR (regexp_replace(papf.full_name,'([^[:graph:]|^[:blank:]])',''), 1, 150) Buyer
	into l_buyer
	from per_all_people_f papf
 where papf.person_id  = :agent_id 
   AND  PAPF.EMPLOYEE_NUMBER IS NOT NULL 
   AND TRUNC(SYSDATE) BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
   AND DECODE(HR_SECURITY.VIEW_ALL ,'Y' , 'TRUE', 
       HR_SECURITY.SHOW_RECORD('PER_ALL_PEOPLE_F',PAPF.PERSON_ID, PAPF.PERSON_TYPE_ID,
			 PAPF.EMPLOYEE_NUMBER,PAPF.APPLICANT_NUMBER )) = 'TRUE' 
  AND DECODE(HR_GENERAL.GET_XBG_PROFILE,'Y', PAPF.BUSINESS_GROUP_ID ,
		 	HR_GENERAL.GET_BUSINESS_GROUP_ID) = PAPF.BUSINESS_GROUP_ID;
		 	return(l_buyer);
exception
	when others then
	srw.message(1254,'When others exception at CF_BUYER :'||sqlerrm);
	return(null);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8053
   NAME = <<"cf_category_codeformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8052
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_CATEGORY_CODEFormula return Char is
l_product_code varchar2(100);
l_inventory_item_id number;
begin

  select mtc.CATEGORY_CONCAT_SEGS
    into l_product_code
    from MTL_ITEM_CATEGORIES_V mtc,mtl_category_sets mcs
   where mtc.inventory_item_id =:item_id
     and  mcs.category_set_id  = mtc.category_set_id
     and  mcs.category_set_id = :C_CATEGORY_SET_ID
     and mtc.organization_id   =:organization_id1; 
   return(l_product_code);  
exception
	when others then
	srw.message(1424,'When others exception at CF_CATEGORY_CODE :'||sqlerrm);
	return(null);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8055
   NAME = <<"cf_period_nameformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8054
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_PERIOD_NAMEFormula return Char is
begin
  return(:P_PERIOD_NAME);
exception
	when others then
	return(null);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8059
   NAME = <<"cf_category_fromformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8058
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_CATEGORY_FROMFormula return Char is
begin
  return(:P_CATEGORY_FROM);
end;  
">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8061
   NAME = <<"cf_category_toformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8060
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_CATEGORY_TOFormula return Char is
begin
  return(:P_CATEGORY_TO);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8063
   NAME = <<"cf_vendor_fromformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8062
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_VENDOR_FROMFormula return Char is
begin
  return(:P_VENDOR_FROM);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8065
   NAME = <<"cf_vendor_toformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8064
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_VENDOR_TOFormula return Char is
begin
  return(:P_VENDOR_TO);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8086
   NAME = <<"cf_inv_funct_amountformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8085
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_INV_FUNCT_AMOUNTFormula return Number is
l_INV_FUNCT_AMOUNT number:=0;
l_INV_FUNCT_AMOUNT2 number:=0;
l_invoice_id    NUMBER :=0 ;
begin 
	srw.message(1520,'invoice_id for :'||l_invoice_id );
	srw.message(1521,'po_header_id for :'||:po_header_id);
	srw.message(1522,'po_line_id for :'||:po_line_id); 
	srw.message(1523,'LINE_LOCATION_ID for :'||:LINE_LOCATION_ID); 
		srw.message(1523,'RCV_TRANSACTION_ID for :'||:RCV_TRANSACTION_ID); 
--	srw.message(1524,'invoice_distribution_id for :'||:invoice_distribution_id);


 l_INV_FUNCT_AMOUNT :=  :Invoice_price * :Invoice_rate * :QTY_INVOICED ;


/*
    SELECT INVOICE_ID
    INTO l_invoice_id
    FROM AP_INVOICES_ALL WHERE INVOICE_NUM = :INVOICE_NUM ;

    select  XAL.ACCOUNTED_CR
     into l_INV_FUNCT_AMOUNT
     from AP_INVOICE_DISTRIBUTIONS_V apv,XLA_DISTRIBUTION_LINKS xdl,XLA_AE_LINES xal,XLA_AE_HEADERS XAH, po_distributions pod
     where 1=1 
     and apv.invoice_id = l_invoice_id
     and apv.po_header_id = :po_header_id
     and apv.po_line_id = :po_line_id--decode(:cf_po_line_id,0,:po_line_id,:cf_po_line_id)
      and pod.LINE_LOCATION_ID =:LINE_LOCATION_ID--456623  --decode(:cf_po_LINE_LOCATION_ID,0,:LINE_LOCATION_ID,:cf_po_LINE_LOCATION_ID)
       AND apv.rcv_transaction_id =:RCV_TRANSACTION_ID
      AND  xdl.AE_LINE_NUM = xal.AE_LINE_NUM
     	AND xdl.ae_HEADER_ID=xal.ae_header_id
      AND xah.ae_header_id = xal.ae_header_id
      AND xal.accounting_class_code ='LIABILITY'
      AND xdl.source_distribution_type = 'AP_INV_DIST'
      and xdl.source_distribution_id_num_1 = APV.invoice_distribution_id
      AND apv.po_distribution_id = pod.po_distribution_id
      AND APV.ASSETS_TRACKING_FLAG='Y'
      AND ROWNUM<2 ;
      
      */
      
 /*SELECT INVOICE_ID
 INTO l_invoice_id
 FROM AP_INVOICES_ALL WHERE INVOICE_NUM = :INVOICE_NUM ;

  select sum(apv.BASE_AMOUNT)
    into l_INV_FUNCT_AMOUNT
	   from AP_INVOICE_DISTRIBUTIONS_V apv, po_distributions pod
   where  apv.po_distribution_id = pod.po_distribution_id
     and apv.invoice_id = l_invoice_id
     and apv.po_header_id = :po_header_id 
     and apv.po_line_id = :po_line_id--decode(:cf_po_line_id,0,:po_line_id,:cf_po_line_id)
      and pod.LINE_LOCATION_ID = :LINE_LOCATION_ID--decode(:cf_po_LINE_LOCATION_ID,0,:LINE_LOCATION_ID,:cf_po_LINE_LOCATION_ID)
     and apv.LINE_TYPE in ('Accrual','Invoice Price Variance'); */
          --and apid.LINE_TYPE_LOOKUP_CODE = 'IPV';  
    -- srw.message(1524,'l_INV_FUNCT_AMOUNT for :'||l_INV_FUNCT_AMOUNT); 
     --return(l_INV_FUNCT_AMOUNT);
  /* IF l_INV_FUNCT_AMOUNT = 0 THEN -- Added on 13 Jan 2013 by Bhabani
     select sum(apv.BASE_AMOUNT)
    into l_INV_FUNCT_AMOUNT2
       from AP_INVOICE_DISTRIBUTIONS_V apv, po_distributions_all pod
   where  apv.po_distribution_id = pod.po_distribution_id
     and apv.invoice_id =:invoice_number
     and apv.po_header_id =:po_header_id 
     and apv.po_line_id =:po_line_id--decode(:cf_po_line_id,0,:po_line_id,:cf_po_line_id)
      and pod.LINE_LOCATION_ID =:LINE_LOCATION_ID--decode(:cf_po_LINE_LOCATION_ID,0,:LINE_LOCATION_ID,:cf_po_LINE_LOCATION_ID)
     and apv.LINE_TYPE in ('Accrual','Invoice Price Variance')
    -- and apv.related_id = :invoice_distribution_id
     group by apv.related_id ;
     srw.message(1525,'l_INV_FUNCT_AMOUNT2 for :'||l_INV_FUNCT_AMOUNT2); 
     return(l_INV_FUNCT_AMOUNT2);-- end on 13 Jan 2013 by Bhabani   	
   else   */
   return(l_INV_FUNCT_AMOUNT); 
  --end if; 
exception
  when too_many_rows then
  select sum(apv.BASE_AMOUNT)
    into l_INV_FUNCT_AMOUNT2
	   from AP_INVOICE_DISTRIBUTIONS_V apv, po_distributions pod
   where  apv.po_distribution_id = pod.po_distribution_id
     and apv.invoice_id = l_invoice_id
     and apv.po_header_id = :po_header_id 
     and apv.po_line_id = :po_line_id--decode(:cf_po_line_id,0,:po_line_id,:cf_po_line_id)
      and pod.LINE_LOCATION_ID = :LINE_LOCATION_ID--decode(:cf_po_LINE_LOCATION_ID,0,:LINE_LOCATION_ID,:cf_po_LINE_LOCATION_ID)
     and apv.LINE_TYPE in ('Accrual','Invoice Price Variance');
     return(l_INV_FUNCT_AMOUNT2);-- end on 13 Jan 2013 by Bhabani   	
	when others then
	srw.message(1526,'When others exception at CF_INV_FUNCT_AMOUNT for :'||:invoice_num||':'||sqlerrm);
--	l_INV_FUNCT_AMOUNT := null;
	return(l_INV_FUNCT_AMOUNT);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8101
   NAME = <<"cf_titleformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8100
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_TITLEFormula return Char is
begin
  return(:p_title);
end;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8113
   NAME = <<"cf_organization_idformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8112
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"function CF_ORGANIZATION_IDFormula return Number is
l_organization_id HR_ORGANIZATION_UNITS_V.organization_id%type;
begin
	select organization_id
	  into l_organization_id
	  from HR_ORGANIZATION_UNITS_V 
   where LOCATION_ID = :ship_to_location_id;
   srw.message(1450,' CF_ORGANIZATION_ID: '||l_organization_id);
   return(l_organization_id);
exception
	when others then
	srw.message(1451,'When others exception at CF_ORGANIZATION_ID: '||sqlerrm);
	return(0);
  end;
  ">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8259
   NAME = <<"cf_charge_accformula">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8257
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"FUNCTION CF_CHARGE_ACCFORMULA RETURN NUMBER IS
  /*L_TRANSACTION_ID NUMBER;
  L_DEST_TYPE_CODE VARCHAR2(240);*/
  L_CHARGE_ACCT    VARCHAR2(240);
BEGIN
-- Commented for Defect # 157 to have Pre SLA Charge Account
/*  BEGIN
    SELECT RT1.TRANSACTION_ID, RT1.DESTINATION_TYPE_CODE
      INTO L_TRANSACTION_ID, L_DEST_TYPE_CODE
      FROM RCV_TRANSACTIONS RT1, RCV_TRANSACTIONS RT2
     WHERE RT2.TRANSACTION_ID = :RCV_TRANSACTION_ID AND
           RT2.SHIPMENT_HEADER_ID = RT1.SHIPMENT_HEADER_ID AND
           RT2.SHIPMENT_LINE_ID = RT1.SHIPMENT_LINE_ID AND
           RT1.TRANSACTION_TYPE = 'DELIVER' AND ROWNUM = 1;
  EXCEPTION
    WHEN OTHERS THEN
      L_TRANSACTION_ID := NULL;
      L_DEST_TYPE_CODE := NULL;
      SRW.MESSAGE(100,
                  'When others exception while deriving delivery trx id in  CF_CHARGE_ACCFormula for (1 RCV Trx Id) :' ||
                  :RCV_TRANSACTION_ID || '(2 Invoice Num) :' ||
                  :INVOICE_NUM || SQLERRM);
  END;

  IF L_DEST_TYPE_CODE = 'INVENTORY' THEN
    SELECT DISTINCT \* XLAL.CODE_COMBINATION_ID,*\
                    GLCC.CONCATENATED_SEGMENTS \*,
                             MMT.RCV_TRANSACTION_ID*\
      INTO L_CHARGE_ACCT
      FROM GL_CODE_COMBINATIONS_KFV  GLCC,
           XLA_AE_LINES              XLAL,
           XLA_DISTRIBUTION_LINKS    XDL,
           MTL_TRANSACTION_ACCOUNTS  MTA,
           MTL_MATERIAL_TRANSACTIONS MMT \*,
                    GL_LEDGERS                GLED*\
     WHERE XLAL.CODE_COMBINATION_ID = GLCC.CODE_COMBINATION_ID AND
           XLAL.AE_HEADER_ID = XDL.AE_HEADER_ID AND
           XLAL.AE_LINE_NUM = XDL.AE_LINE_NUM AND
           XLAL.APPLICATION_ID = XDL.APPLICATION_ID AND
           XLAL.APPLICATION_ID = 707 AND
           XDL.SOURCE_DISTRIBUTION_ID_NUM_1 = MTA.INV_SUB_LEDGER_ID AND
           XDL.SOURCE_DISTRIBUTION_TYPE = 'MTL_TRANSACTION_ACCOUNTS' AND
           MTA.TRANSACTION_ID = MMT.TRANSACTION_ID AND
           MMT.RCV_TRANSACTION_ID = L_TRANSACTION_ID \*2708469*\ \*7017669*\
           AND MTA.ACCOUNTING_LINE_TYPE = 1 -- Inventory Val
           AND XLAL.ACCOUNTING_CLASS_CODE = 'INVENTORY_VALUATION' AND
           XLAL.LEDGER_ID = :SET_OF_BOOKS;
  ELSIF L_DEST_TYPE_CODE = 'SHOP FLOOR' THEN
    SELECT DISTINCT \* XLAL.CODE_COMBINATION_ID,*\
                    GLCC.CONCATENATED_SEGMENTS \*,
                             MMT.RCV_TRANSACTION_ID*\
      INTO L_CHARGE_ACCT
      FROM GL_CODE_COMBINATIONS_KFV GLCC,
           XLA_AE_LINES             XLAL,
           XLA_DISTRIBUTION_LINKS   XDL,
           WIP_TRANSACTION_ACCOUNTS WTA,
           WIP_TRANSACTIONS         WT \*,
                    GL_LEDGERS                GLED*\
     WHERE XLAL.CODE_COMBINATION_ID = GLCC.CODE_COMBINATION_ID AND
           XLAL.AE_HEADER_ID = XDL.AE_HEADER_ID AND
           XLAL.AE_LINE_NUM = XDL.AE_LINE_NUM AND
           XLAL.APPLICATION_ID = XDL.APPLICATION_ID AND
           XLAL.APPLICATION_ID = 707 AND
           XDL.SOURCE_DISTRIBUTION_ID_NUM_1 = WTA.WIP_SUB_LEDGER_ID AND
           XDL.SOURCE_DISTRIBUTION_TYPE = 'WIP_TRANSACTION_ACCOUNTS' AND
           WTA.TRANSACTION_ID = WT.TRANSACTION_ID AND
           WT.RCV_TRANSACTION_ID = L_TRANSACTION_ID \*2708469*\ \*7017669*\
           AND WTA.ACCOUNTING_LINE_TYPE = 7 -- Inventory Val
           AND XLAL.ACCOUNTING_CLASS_CODE = 'WIP_VALUATION' AND
           XLAL.LEDGER_ID = :SET_OF_BOOKS;
  END IF;*/
-- Commented for Defect # 157 to have Pre SLA Charge Account Ends
-- Added for Defect # 157 to have Pre SLA Charge Account
   
  SELECT GLCC.CONCATENATED_SEGMENTS
  INTO L_CHARGE_ACCT
  FROM  GL_CODE_COMBINATIONS_KFV GLCC
  WHERE GLCC.CODE_COMBINATION_ID = :POD_CCID;
  
  :CP_CHARGE_ACT := L_CHARGE_ACCT;
  RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    SRW.MESSAGE(100,
                'When others exception in  CF_CHARGE_ACCFormula for (1 POD_CCID) :' ||
                :POD_CCID || ' (2 Invoice Num) :' || :INVOICE_NUM ||
                SQLERRM);
    L_CHARGE_ACCT  := NULL;
    :CP_CHARGE_ACT := L_CHARGE_ACCT;
    RETURN 0;
END;">>
   STATE = 0
END

DEFINE  TOOL_PLSQL
BEGIN
   ITEMID = 8323
   NAME = <<"cf_price_hold_released_byformu">>
   PLSLFID_EP = (BLONG) NULLP
   OBJECT_ID = 8322
   TYPE = 4
   PLSLFID_ST = (TLONG)
<<"--Added by Soniya for CR 6510 - Reporting Requirement for IPV Analysis on Inventory Destined PO's.
FUNCTION cf_price_hold_released_byformu RETURN CHAR IS
  v_release_by_user_name VARCHAR2(100);
  v_full_name            VARCHAR2(240);

BEGIN

  BEGIN
  
    SELECT DISTINCT aph.release_by_user_name
      INTO v_release_by_user_name
      FROM ap_holds_v aph
     WHERE aph.line_location_id = :line_location_id AND
           aph.invoice_id = :invoice_id AND aph.hold_lookup_code = 'PRICE' AND
           aph.status_flag IS NOT NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_release_by_user_name := NULL;
      v_full_name            := '';
  END;

  IF v_release_by_user_name IS NOT NULL THEN
    BEGIN
      SELECT DISTINCT ppf.full_name
        INTO v_full_name
        FROM per_all_people_f ppf, fnd_user fu
       WHERE fu.user_name = v_release_by_user_name AND
             ppf.person_id = fu.employee_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_full_name := v_release_by_user_name;
    END;
  ELSE
    v_full_name := '';
  END IF;

  RETURN v_full_name;
EXCEPTION
  WHEN OTHERS THEN
    srw.message(6510, 'line_location_id : ' || :line_location_id);
    srw.message(6510, 'invoice_id : ' || :invoice_id);
  
    RETURN '';
END;">>
   STATE = 0
END

DEFINE  SRW2_QUERY
BEGIN
   ITEMID = 103
   NAME = <<"Q_company">>
   TAG = 0
   DISP_ORDER = 9
   QUERYLFID = (TLONG)
<<"SELECT   gsb.name                      c_company
,        fsp.inventory_organization_id c_organization_id
,        gsb.currency_code             GL_CURRENCY
,        gsb.chart_of_accounts_id      STRUCTURE_ACC
,        mdv.structure_id              STRUCTURE_CAT
,        mdv.category_set_id           c_category_set_id
,        flo1.meaning                  c_yes
,        flo2.meaning                  c_no
,        fc.precision                   c_precision
,        nvl(fc.extended_precision,fc.precision)  c_ext_precision
,        fsp.set_of_books_id      set_of_books
FROM     gl_sets_of_books              gsb
,        financials_system_parameters  fsp
,        mtl_default_sets_view         mdv
,        fnd_lookups                   flo1
,        fnd_lookups                   flo2
,        fnd_currencies               fc
WHERE    gsb.set_of_books_id           = fsp.set_of_books_id
AND      mdv.functional_area_id        = 2
AND      flo1.lookup_type              = 'YES_NO'
AND      flo1.lookup_code              = 'Y'
AND      flo2.lookup_type              = 'YES_NO'
AND      flo2.lookup_code              = 'N'
AND      fc.enabled_flag = 'Y'
AND      fc.currency_code = gsb.currency_code
">>
   NET_LOGON = NULLP
   EXT_QUERY = NULLP
   TEMP_TABLE = NULLP
   TEMP_FLAGS = 0
   EXEC_FREQ = 0
   MAX_ROWS = 0
   X = 5735
   Y = 8192
   WD = 8192
   HT = 4096
   PERS_FLAGS = 0
   DSTYPE = 0
   PLUGINXML = NULLP
   PLUGINCLZ = NULLP
   MAJORVER = 0
   MINORVER = 0
   SIGNONPRM = 0
   PLUGINXMLID = (TLONG) NULLP
END

DEFINE  SRW2_QUERY
BEGIN
   ITEMID = 3128
   NAME = <<"Q_Pos">>
   TAG = 0
   DISP_ORDER = 3
   QUERYLFID = (TLONG)
<<"-- Code has been modified/restructured to improve performance using same conditions by Sayikrishna for PTASK0000320 on 08-Mar-2022
/* -- Commented whole code and separate section below added as part of PTASK0000320
SELECT 
 apipv.invoice_num invoice_num,
 apipv.invoice_date invoice_date,
 DECODE(DECODE(apipv.quantity_invoiced,
               0,
               0,
               NULL,
               0,
               NVL(apipv.quantity_invoiced, 1) /
               ABS(NVL(apipv.quantity_invoiced, 1))),
        0,
        plc1.displayed_field,
        1,
        plc2.displayed_field,
        -1,
        plc3.displayed_field) entry_type,
 &p_flex_cat c_flex_cat,
 &p_flex_item c_flex_item,
 xal_var.concatenated_segments c_var_acct, */
 /*&P_FLEX_VAR_ACCT C_VAR_ACCT*/
 /*&P_FLEX_CHARGE_ACCT C_CHARGE_ACCT,*/
 /*
 xal_erv.concatenated_segments c_var_acct_erv,
 round((apipv.quantity_invoiced / (decode(pll.match_option,
                                          'R',
                                          po_uom_s.po_uom_convert_p(pol.unit_meas_lookup_code,
                                                                    rct.unit_of_measure,
                                                                    pol.item_id),
                                          1))),
       20) qty_invoiced,
 NVL(apipv.invoice_rate, 1) invoice_rate,
 apipv.invoice_amount invoice_amount,
 apipv.invoice_price invoice_price,*/
 /* nvl(pod.rate, nvl(poh.rate, 1)) Po_rate,CR11329*/
 /*NVL(NVL(rct.currency_conversion_rate, poh.rate), 1) po_rate,
 pll.price_override po_price,
 rct.unit_of_measure receipt_unit,
 pol.item_id item_id,
 msi.description item_description,
 pov.vendor_name vendor,
 DECODE(poh.type_lookup_code,
        'BLANKET',
        poh.segment1 || ' - ' || por.release_num,
        'PLANNED',
        poh.segment1 || ' - ' || por.release_num,
        poh.segment1) po_number_release,
 poh.currency_code currency,
 apipv.invoice_currency invoice_currency,
 pol.line_num line_num,
 pol.unit_meas_lookup_code unit,
 lot.location_code LOCATION,
 ROUND(DECODE(apipv.quantity_invoiced,
              0,
              DECODE(apipv.price_var,
                     NULL,
                     DECODE(apipv.invoice_rate,
                            NULL,
                            apipv.invoice_amount,
                            apipv.invoice_base_amount),
                     apipv.price_var * NVL(apipv.invoice_rate, 1)),
              NULL,
              DECODE(apipv.price_var,
                     NULL,
                     DECODE(apipv.invoice_rate,
                            NULL,
                            apipv.invoice_amount,
                            apipv.invoice_base_amount),
                     apipv.price_var * NVL(apipv.invoice_rate, 1)),
              apipv.invoice_price * NVL(apipv.invoice_rate, 1)) *
       (DECODE(pll.match_option,
               'R',
               po_uom_s.po_uom_convert_p(pol.unit_meas_lookup_code,
                                         rct.unit_of_measure,
                                         pol.item_id),
               1)),
       :c_ext_precision) invoice_base_price,
 ROUND(pll.price_override * DECODE(pll.match_option,
                                   'R',
                                   DECODE(rct.transaction_id,
                                          NULL,
                                          NVL(poh.rate, 1),
                                          NVL(rct.currency_conversion_rate, 1)),
                                   NVL(poh.rate, 1)),
       :c_ext_precision) po_base_price,
 decode(apipv.invoice_rate, null, apipv.price_var, apipv.base_price_var) base_inv_price_var,
 apipv.exch_rate_var ex_rate_vari,
 pod.code_combination_id pod_ccid, -- Defect # 157
 pov.vendor_type_lookup_code vendor_type, --Bug#2454449
 pov.segment1 vendor_number, --Bug#2454449
 msi.organization_id,
 poh.agent_id,
 apipv.po_distribution_id,
 poh.po_header_id,
 pol.po_line_id,
 pll.line_location_id,
 poh.ship_to_location_id,
 apipv.rcv_transaction_id,
 --Added by Soniya for CR 6510 - Reporting Requirement for IPV Analysis on Inventory Destined PO's. 
 apipv.invoice_id,
 (SELECT DISTINCT DECODE(aph.hold_lookup_code, 'PRICE', 'Y', 'N')
    FROM ap_holds_v aph
   WHERE pll.line_location_id = aph.line_location_id
     AND apipv.invoice_id = aph.invoice_id
     AND aph.hold_lookup_code = 'PRICE') price_hold_exists
--End of code changes for CR 6510 - Reporting Requirement for IPV Analysis on Inventory Destined PO's.     
  FROM */
		/*gl_code_combinations gcc1,
       gl_code_combinations gcc,*/ /* gl_period_statuses glps, */ 
      /* po_distributions pod,
       po_line_locations pll,
       po_lines pol,
       po_releases por,
       po_headers poh,
       po_vendors pov,
       xxap_invoice_price_var_v apipv, --ap_invoice_price_var_v CR11542
       (SELECT xdl.source_distribution_id_num_1,
               xdl.applied_to_source_id_num_1,
               gcc1.concatenated_segments,
               gcc1.code_combination_id
          FROM xla_distribution_links   xdl,
               xla_ae_headers           xah,
               xla_ae_lines             xal,
               gl_code_combinations_kfv gcc1
         WHERE xdl.source_distribution_type(+) = 'AP_INV_DIST'
           AND xdl.applied_to_entity_code = 'AP_INVOICES'
           AND xdl.alloc_to_distribution_type = 'AP_INV_DIST'
           AND xdl.accounting_line_code IN
               ('AP_INV_PRICE_VAR_INV',
                'AP_INV_PRICE_VAR_CM',
                'AP_INV_PRICE_VAR_DM')
           AND xdl.application_id = 200
           AND xdl.event_class_code IN
               ('INVOICES', 'CREDIT MEMOS', 'DEBIT MEMOS')
           AND xah.event_id = xdl.event_id
           AND xah.ledger_id = :set_of_books
           AND xah.accounting_entry_status_code = 'F'
           AND xah.application_id = 200
           AND xah.ae_header_id = xdl.ae_header_id
           AND xal.ledger_id = :set_of_books
           AND xal.application_id = 200
           AND xal.ae_header_id = xah.ae_header_id
           AND xal.ae_line_num = xdl.ae_line_num
           AND xal.ae_header_id = xdl.ae_header_id
           AND xal.application_id = xdl.application_id
           AND gcc1.code_combination_id = xal.code_combination_id) xal_var,
       (SELECT xdl.source_distribution_id_num_1,
               xdl.applied_to_source_id_num_1,
               gcc_erv.concatenated_segments,
               gcc_erv.code_combination_id
          FROM xla_distribution_links   xdl,
               xla_ae_headers           xah,
               xla_ae_lines             xal,
               gl_code_combinations_kfv gcc_erv
         WHERE xdl.source_distribution_type(+) = 'AP_INV_DIST'
           AND xdl.applied_to_entity_code = 'AP_INVOICES'
           AND xdl.alloc_to_distribution_type = 'AP_INV_DIST'
           AND xdl.accounting_line_code IN
               ('AP_EX_RATE_VAR_INV',
                'AP_EX_RATE_VAR_CM',
                'AP_EX_RATE_VAR_DM')
           AND xdl.application_id = 200
           AND xdl.event_class_code IN
               ('INVOICES', 'CREDIT MEMOS', 'DEBIT MEMOS')
           AND xah.event_id = xdl.event_id
           AND xah.ledger_id = :set_of_books
           AND xah.accounting_entry_status_code = 'F'
           AND xah.application_id = 200
           AND xah.ae_header_id = xdl.ae_header_id
           AND xal.ledger_id = :set_of_books
           AND xal.application_id = 200
           AND xal.ae_header_id = xah.ae_header_id
           AND xal.ae_line_num = xdl.ae_line_num
           AND xal.ae_header_id = xdl.ae_header_id
           AND xal.application_id = xdl.application_id
           AND gcc_erv.code_combination_id = xal.code_combination_id) xal_erv, --Defect 16415
       mtl_system_items msi,
       mtl_categories mca,
       po_lookup_codes plc1,
       po_lookup_codes plc2,
       po_lookup_codes plc3,
       hr_locations_all_tl lot,
       rcv_transactions rct
 WHERE apipv.po_distribution_id = pod.po_distribution_id
   AND pod.line_location_id = pll.line_location_id
   AND pll.po_line_id = pol.po_line_id
   AND pol.po_header_id = poh.po_header_id
   AND pll.po_release_id = por.po_release_id(+)
   AND poh.vendor_id = pov.vendor_id(+)
   AND pol.item_id = msi.inventory_item_id(+)
   AND msi.organization_id = :c_organization_id
   AND pol.category_id = mca.category_id */
      /* AND gcc.code_combination_id = pod.code_combination_id
      AND gcc1.code_combination_id = pod.variance_account_id -- CR11542*/
  /* AND xal_var.source_distribution_id_num_1(+) = apipv.ap_distribution_id
   AND xal_var.applied_to_source_id_num_1(+) = apipv.invoice_id
   AND xal_erv.source_distribution_id_num_1(+) =
       apipv.ap_distribution_id_erv
   AND xal_erv.applied_to_source_id_num_1(+) = apipv.invoice_id
   AND lot.location_id(+) = pll.ship_to_location_id
   AND pll.ship_to_location_id IS NOT NULL
   AND lot.LANGUAGE(+) = USERENV('LANG')
   AND pod.destination_type_code IN ('INVENTORY', 'SHOP FLOOR')
   AND plc1.lookup_type = 'POXRCIPV'
   AND plc1.lookup_code = 'ADJUSTMENT'
   AND plc2.lookup_type = 'POXRCIPV'
   AND plc2.lookup_code = 'ENTRY'
   AND plc3.lookup_type = 'POXRCIPV'
   AND plc3.lookup_code = 'REVERSAL' */
    /* commented out for RT9001090 
   AND NVL(pov.vendor_name, 'A') BETWEEN
       NVL(:p_vendor_from, NVL(pov.vendor_name, 'A')) AND
       NVL(:p_vendor_to, NVL(pov.vendor_name, 'A'))
   */    
   /* commented out for RT9001090 
   AND glps.application_id = 201
   AND glps.set_of_books_id = :set_of_books
   AND glps.period_name = NVL(:p_period_name, glps.period_name)
   AND apipv.accounting_date BETWEEN glps.start_date AND glps.end_date
   */
  /* AND apipv.rcv_transaction_id = rct.transaction_id(+)
   AND poh.type_lookup_code IN ('STANDARD', 'BLANKET', 'PLANNED')
   AND pll.shipment_type IN ('STANDARD', 'BLANKET', 'SCHEDULED')
   AND ((DECODE(apipv.invoice_rate,
                NULL,
                apipv.price_var,
                apipv.base_price_var) <> 0) OR (apipv.exch_rate_var <> 0)) --Defect # 157
   AND &p_where_cat
   &p_where_vendor_name
 ORDER BY 2, 12
 */-- End Commented. Below is the New restructure code for PTASK0000320
 SELECT /*+ leading( apipv )*/ 
 apipv.invoice_num invoice_num,
 apipv.invoice_date invoice_date,
DECODE(DECODE(apipv.quantity_invoiced,
               0,
               0,
               NULL,
               0,
               NVL(apipv.quantity_invoiced, 1) /
               ABS(NVL(apipv.quantity_invoiced, 1))),
        0,
        --plc1.displayed_field,
        (   SELECT  meaning
        FROM  fnd_lookup_values lv
        WHERE   lv.language = userenv('LANG')
                AND lv.view_application_id = 201
                AND lv.security_group_id = fnd_global.lookup_security_group(lv.lookup_type, lv.view_application_id)
                AND lv.lookup_type = 'POXRCIPV'
                AND lv.lookup_code = 'ADJUSTMENT'),
        1,
         (   SELECT  meaning
        FROM  fnd_lookup_values lv
        WHERE   lv.language = userenv('LANG')
                AND lv.view_application_id = 201
                AND lv.security_group_id = fnd_global.lookup_security_group(lv.lookup_type, lv.view_application_id)
                AND lv.lookup_type = 'POXRCIPV'
                AND lv.lookup_code = 'ENTRY'),-- plc2.displayed_field,
        -1,
          (   SELECT  meaning
        FROM  fnd_lookup_values lv
        WHERE   lv.language = userenv('LANG')
                AND lv.view_application_id = 201
                AND lv.security_group_id = fnd_global.lookup_security_group(lv.lookup_type, lv.view_application_id)
                AND lv.lookup_type = 'POXRCIPV'
                AND lv.lookup_code = 'REVERSAL')
        --plc3.displayed_field
        ) entry_type, 
 &p_flex_cat c_flex_cat,
 &p_flex_item c_flex_item,
 xal_var.concatenated_segments c_var_acct,
  xal_erv.concatenated_segments c_var_acct_erv,
 round((apipv.quantity_invoiced / (decode(pll.match_option,
                                          'R',
                                          po_uom_s.po_uom_convert_p(pol.unit_meas_lookup_code,
                                                                    rct.unit_of_measure,
                                                                    pol.item_id),
                                          1))),
       20) qty_invoiced,
 NVL(apipv.invoice_rate, 1) invoice_rate,
 apipv.invoice_amount invoice_amount,
 apipv.invoice_price invoice_price,
 NVL(NVL(rct.currency_conversion_rate, poh.rate), 1) po_rate,
 pll.price_override po_price,
 rct.unit_of_measure receipt_unit,
 pol.item_id item_id,
 msi.description item_description,
 pov.vendor_name vendor,
 DECODE(poh.type_lookup_code,
        'BLANKET',
        poh.segment1 || ' - ' || por.release_num,
        'PLANNED',
        poh.segment1 || ' - ' || por.release_num,
        poh.segment1) po_number_release,
 poh.currency_code currency,
 apipv.invoice_currency invoice_currency,
 pol.line_num line_num,
 pol.unit_meas_lookup_code unit,
 lot.location_code LOCATION,
 ROUND(DECODE(apipv.quantity_invoiced,
              0,
              DECODE(apipv.price_var,
                     NULL,
                     DECODE(apipv.invoice_rate,
                            NULL,
                            apipv.invoice_amount,
                            apipv.invoice_base_amount),
                     apipv.price_var * NVL(apipv.invoice_rate, 1)),
              NULL,
              DECODE(apipv.price_var,
                     NULL,
                     DECODE(apipv.invoice_rate,
                            NULL,
                            apipv.invoice_amount,
                            apipv.invoice_base_amount),
                     apipv.price_var * NVL(apipv.invoice_rate, 1)),
              apipv.invoice_price * NVL(apipv.invoice_rate, 1)) *
       (DECODE(pll.match_option,
               'R',
               po_uom_s.po_uom_convert_p(pol.unit_meas_lookup_code,
                                         rct.unit_of_measure,
                                         pol.item_id),
               1)),
       :c_ext_precision) invoice_base_price,
 ROUND(pll.price_override * DECODE(pll.match_option,
                                   'R',
                                   DECODE(rct.transaction_id,
                                          NULL,
                                          NVL(poh.rate, 1),
                                          NVL(rct.currency_conversion_rate, 1)),
                                   NVL(poh.rate, 1)),
       :c_ext_precision) po_base_price,
 decode(apipv.invoice_rate, null, apipv.price_var, apipv.base_price_var) base_inv_price_var,
 apipv.exch_rate_var ex_rate_vari,
 pod.code_combination_id pod_ccid, -- Defect # 157
 pov.vendor_type_lookup_code vendor_type, --Bug#2454449
 pov.segment1 vendor_number, --Bug#2454449
 msi.organization_id,
 poh.agent_id,
 apipv.po_distribution_id,
 poh.po_header_id,
 pol.po_line_id,
 pll.line_location_id,
 poh.ship_to_location_id,
 apipv.rcv_transaction_id,
 --Added by Soniya for CR 6510 - Reporting Requirement for IPV Analysis on Inventory Destined PO's. 
 apipv.invoice_id,
 (SELECT DISTINCT DECODE(aph.hold_lookup_code, 'PRICE', 'Y', 'N')
    FROM ap_holds_v aph
   WHERE pll.line_location_id = aph.line_location_id
     AND apipv.invoice_id = aph.invoice_id
     AND aph.hold_lookup_code = 'PRICE') price_hold_exists
--End of code changes for CR 6510 - Reporting Requirement for IPV Analysis on Inventory Destined PO's. 
 from xxap_invoice_price_var_v apipv
    , po_distributions pod
    , po_line_locations pll
    , po_lines pol
    , po_headers poh
    , po_releases por
    , mtl_system_items msi
    , mtl_categories mca
    , rcv_transactions rct
,   (SELECT xdl.source_distribution_id_num_1,
               xdl.applied_to_source_id_num_1,
               gcc1.concatenated_segments,
               gcc1.code_combination_id
          FROM xla_distribution_links   xdl,
               xla_ae_headers           xah,
               xla_ae_lines             xal,
               gl_code_combinations_kfv gcc1
         WHERE xdl.source_distribution_type(+) = 'AP_INV_DIST'
           AND xdl.applied_to_entity_code = 'AP_INVOICES'
           AND xdl.alloc_to_distribution_type = 'AP_INV_DIST'
           AND xdl.accounting_line_code IN
               ('AP_INV_PRICE_VAR_INV',
                'AP_INV_PRICE_VAR_CM',
                'AP_INV_PRICE_VAR_DM')
           AND xdl.application_id = 200
           AND xdl.event_class_code IN  ('INVOICES', 'CREDIT MEMOS', 'DEBIT MEMOS')
           AND xah.event_id = xdl.event_id
           AND xah.ledger_id = :set_of_books
           AND xah.accounting_entry_status_code = 'F'
           AND xah.application_id = 200
           AND xah.ae_header_id = xdl.ae_header_id
           AND xal.ledger_id = :set_of_books
           AND xal.application_id = 200
           AND xal.ae_header_id = xah.ae_header_id
           AND xal.ae_line_num = xdl.ae_line_num
           AND xal.ae_header_id = xdl.ae_header_id
           AND xal.application_id = xdl.application_id
           AND gcc1.code_combination_id = xal.code_combination_id) xal_var
,   (SELECT   xdl.source_distribution_id_num_1,
               xdl.applied_to_source_id_num_1,
               gcc_erv.concatenated_segments,
               gcc_erv.code_combination_id
          FROM xla_distribution_links   xdl,
               xla_ae_headers           xah,
               xla_ae_lines             xal,
               gl_code_combinations_kfv gcc_erv
         WHERE xdl.source_distribution_type(+) = 'AP_INV_DIST'
           AND xdl.applied_to_entity_code = 'AP_INVOICES'
           AND xdl.alloc_to_distribution_type = 'AP_INV_DIST'
           AND xdl.accounting_line_code IN ('AP_EX_RATE_VAR_INV',  'AP_EX_RATE_VAR_CM',  'AP_EX_RATE_VAR_DM')
           AND xdl.application_id = 200
           AND xdl.event_class_code IN  ('INVOICES', 'CREDIT MEMOS', 'DEBIT MEMOS')
           AND xah.event_id = xdl.event_id
           AND xah.ledger_id = :set_of_books
           AND xah.accounting_entry_status_code = 'F'
           AND xah.application_id = 200
           AND xah.ae_header_id = xdl.ae_header_id
           AND xal.ledger_id = :set_of_books
           AND xal.application_id = 200
           AND xal.ae_header_id = xah.ae_header_id
           AND xal.ae_line_num = xdl.ae_line_num
           AND xal.ae_header_id = xdl.ae_header_id
           AND xal.application_id = xdl.application_id
           AND gcc_erv.code_combination_id = xal.code_combination_id) xal_erv 
,    hr_locations_all_tl lot  
,    po_vendors pov
  WHERE   1=1
  AND apipv.po_distribution_id = pod.po_distribution_id
  AND pod.destination_type_code IN ('INVENTORY', 'SHOP FLOOR')
  AND pod.line_location_id = pll.line_location_id
  AND pll.ship_to_location_id IS NOT NULL
  AND pll.po_line_id = pol.po_line_id
  AND pll.shipment_type IN ('STANDARD', 'BLANKET', 'SCHEDULED')
  AND pol.po_header_id = poh.po_header_id
  AND poh.type_lookup_code IN ('STANDARD', 'BLANKET', 'PLANNED')
  AND pll.po_release_id = por.po_release_id(+)
  AND pol.item_id = msi.inventory_item_id(+) 
  AND msi.organization_id = :c_organization_id
  AND pol.category_id = mca.category_id
  AND apipv.rcv_transaction_id = rct.transaction_id(+)
  AND ((DECODE(apipv.invoice_rate, NULL,apipv.price_var,apipv.base_price_var) <> 0) OR (apipv.exch_rate_var <> 0))
  AND xal_var.source_distribution_id_num_1(+) = apipv.ap_distribution_id
  AND xal_var.applied_to_source_id_num_1(+) = apipv.invoice_id  
  AND xal_erv.source_distribution_id_num_1(+) = apipv.ap_distribution_id_erv
  AND xal_erv.applied_to_source_id_num_1(+) = apipv.invoice_id
  AND lot.location_id(+) = pll.ship_to_location_id
  AND lot.LANGUAGE(+) = USERENV('LANG')
  AND poh.vendor_id = pov.vendor_id(+)
  AND &p_where_cat
	  &p_where_vendor_name
ORDER BY 2, 12 ">>
   NET_LOGON = NULLP
   EXT_QUERY = NULLP
   TEMP_TABLE = NULLP
   TEMP_FLAGS = 0
   EXEC_FREQ = 0
   MAX_ROWS = 0
   X = 26215
   Y = 8192
   WD = 8192
   HT = 4096
   PERS_FLAGS = 16
   DSTYPE = 0
   PLUGINXML = NULLP
   PLUGINCLZ = NULLP
   MAJORVER = 0
   MINORVER = 0
   SIGNONPRM = 0
   PLUGINXMLID = (TLONG) NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 116
   NAME = <<"B_report_date">>
   TAG = 6937
   DISP_ORDER = 93
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 44772
   Y = 0
   WD = 10332
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000aee4 00000000 0000285c 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 121
   NAME = <<"B_page_of">>
   TAG = 6937
   DISP_ORDER = 98
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 60516
   Y = 1365
   WD = 1968
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000ec64 00000555 000007b0 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 153
   NAME = <<"B_h_report_date">>
   TAG = 6937
   DISP_ORDER = 115
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 45756
   Y = 0
   WD = 10332
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000b2bc 00000000 0000285c 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 155
   NAME = <<"B_6">>
   TAG = 6937
   DISP_ORDER = 114
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 12300
   Y = 5461
   WD = 10824
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000300c 00001555 00002a48 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 780
   NAME = <<"B_FLEX_CAT_DISP">>
   TAG = 6937
   DISP_ORDER = 10
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 4920
   Y = 0
   WD = 4428
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00001338 00000000 0000114c 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   TEXT_WRAP = 4
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 785
   NAME = <<"B_FLEX_ITEM_DISP">>
   TAG = 6937
   DISP_ORDER = 11
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 6888
   Y = 1365
   WD = 2460
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00001ae8 00000555 0000099c 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   TEXT_WRAP = 4
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 787
   NAME = <<"B_Description">>
   TAG = 6937
   DISP_ORDER = 12
   FORMATFLAG = 536871936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 3444
   Y = 2731
   WD = 5904
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000d74 00000aab 00001710 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 1
   MAX_LINES = -1
   TEXT_WRAP = 4
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 1430
   NAME = <<"B_nodata_found">>
   TAG = 6937
   DISP_ORDER = 16
   FORMATFLAG = 268437504
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 40960
   WD = 64944
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 0000a000 0000fdb0 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 68
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 1432
   NAME = <<"B_Item_Total">>
   TAG = 6937
   DISP_ORDER = 17
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 28672
   WD = 10332
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 00007000 0000285c 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 1440
   NAME = <<"B_Category_Total">>
   TAG = 6937
   DISP_ORDER = 18
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 31403
   WD = 11316
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 00007aab 00002c34 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 2045
   NAME = <<"B_Vendor_subtotal">>
   TAG = 6937
   DISP_ORDER = 7
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 25941
   WD = 7872
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 00006555 00001ec0 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 2870
   NAME = <<"B_4">>
   TAG = 6937
   DISP_ORDER = 110
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 8856
   Y = 8192
   WD = 12792
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002298 00002000 000031f8 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 2872
   NAME = <<"B_5">>
   TAG = 6937
   DISP_ORDER = 111
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 19680
   Y = 9557
   WD = 1968
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00004ce0 00002555 000007b0 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 3041
   NAME = <<"B_report_title">>
   TAG = 6937
   DISP_ORDER = 99
   FORMATFLAG = 536903936
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 0
   WD = 21648
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00000000 00005490 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 68
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 3057
   NAME = <<"B_Title">>
   TAG = 6937
   DISP_ORDER = 116
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 0
   WD = 21648
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00000000 00005490 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 68
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 3210
   NAME = <<"B_total_barline">>
   TAG = 6937
   DISP_ORDER = 65
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 24576
   WD = 7652
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c10c 00006000 00001de4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 3365
   NAME = <<"B_vendor_fr_title">>
   TAG = 6937
   DISP_ORDER = 108
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 12792
   Y = 10923
   WD = 8856
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000031f8 00002aab 00002298 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 3366
   NAME = <<"B_period_name">>
   TAG = 6937
   DISP_ORDER = 105
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 13653
   WD = 492
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00003555 000001ec 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 3369
   NAME = <<"B_vendor_to_Title">>
   TAG = 6937
   DISP_ORDER = 109
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 14268
   Y = 12288
   WD = 7380
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000037bc 00003000 00001cd4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 5389
   NAME = <<"B_item_total_bar">>
   TAG = 6937
   DISP_ORDER = 71
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 27307
   WD = 7652
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c10c 00006aab 00001de4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 5390
   NAME = <<"B_category_total_bar">>
   TAG = 6937
   DISP_ORDER = 72
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 30037
   WD = 7652
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c10c 00007555 00001de4 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6367
   NAME = <<"B_page_of1">>
   TAG = 6937
   DISP_ORDER = 120
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 60516
   Y = 1365
   WD = 1968
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000ec64 00000555 000007b0 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6371
   NAME = <<"B_page1">>
   TAG = 6937
   DISP_ORDER = 117
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 45756
   Y = 1365
   WD = 10332
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000b2bc 00000555 0000285c 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6478
   NAME = <<"B_category_total_bar1">>
   TAG = 6937
   DISP_ORDER = 73
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 32768
   WD = 7652
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c10c 00008000 00001de4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6483
   NAME = <<"B_1">>
   TAG = 6937
   DISP_ORDER = 75
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 34133
   WD = 11316
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 00008555 00002c34 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6729
   NAME = <<"B_dash">>
   TAG = 6937
   DISP_ORDER = 77
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49420
   Y = 35499
   WD = 7652
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c10c 00008aab 00001de4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6810
   NAME = <<"B_sort_by1">>
   TAG = 6937
   DISP_ORDER = 122
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 8192
   WD = 492
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00002000 000001ec 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6812
   NAME = <<"B_2">>
   TAG = 6937
   DISP_ORDER = 123
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 9557
   WD = 492
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00002555 000001ec 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6813
   NAME = <<"B_vendor_fr_title1">>
   TAG = 6937
   DISP_ORDER = 124
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 10923
   WD = 492
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00002aab 000001ec 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6814
   NAME = <<"B_vendor_to_Title1">>
   TAG = 6937
   DISP_ORDER = 125
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 21648
   Y = 12288
   WD = 492
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005490 00003000 000001ec 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6815
   NAME = <<"B_period_name1">>
   TAG = 6937
   DISP_ORDER = 126
   FORMATFLAG = 603980032
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 13284
   Y = 13653
   WD = 8364
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000033e4 00003555 000020ac 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6818
   NAME = <<"B_h_report_date1">>
   TAG = 6937
   DISP_ORDER = 127
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 56088
   Y = 0
   WD = 492
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000db18 00000000 000001ec 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6820
   NAME = <<"B_page3">>
   TAG = 6937
   DISP_ORDER = 128
   FORMATFLAG = 1946157312
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 56088
   Y = 1365
   WD = 492
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000db18 00000555 000001ec 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6821
   NAME = <<"B_page2">>
   TAG = 6937
   DISP_ORDER = 101
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 55104
   Y = 1365
   WD = 492
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000d740 00000555 000001ec 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6823
   NAME = <<"B_page4">>
   TAG = 6937
   DISP_ORDER = 95
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 45756
   Y = 1365
   WD = 9348
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000b2bc 00000555 00002484 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6824
   NAME = <<"B_report_date1">>
   TAG = 6937
   DISP_ORDER = 94
   FORMATFLAG = 1879081216
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 55104
   Y = 0
   WD = 492
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000d740 00000000 000001ec 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6825
   NAME = <<"B_Vendor1">>
   TAG = 6937
   DISP_ORDER = 78
   FORMATFLAG = 1879048448
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 8192
   WD = 19680
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 00002000 00004ce0 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6826
   NAME = <<"B_Vendor2">>
   TAG = 6937
   DISP_ORDER = 13
   FORMATFLAG = 1879048448
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 0
   Y = 6827
   WD = 19680
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00000000 00001aab 00004ce0 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6827
   NAME = <<"B_PO_Number_Release1">>
   TAG = 6937
   DISP_ORDER = 14
   FORMATFLAG = 1879048448
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 984
   Y = 9557
   WD = 9840
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000003d8 00002555 00002670 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6828
   NAME = <<"B_PO_Number_Release2">>
   TAG = 6937
   DISP_ORDER = 15
   FORMATFLAG = 1879048448
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 984
   Y = 10923
   WD = 9840
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000003d8 00002aab 00002670 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6829
   NAME = <<"B_line_num1">>
   TAG = 6937
   DISP_ORDER = 22
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 11316
   Y = 9557
   WD = 1968
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002c34 00002555 000007b0 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6830
   NAME = <<"B_line_num2">>
   TAG = 6937
   DISP_ORDER = 23
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 11316
   Y = 10923
   WD = 1968
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002c34 00002aab 000007b0 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6831
   NAME = <<"B_Ship_to_location1">>
   TAG = 6937
   DISP_ORDER = 24
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 13776
   Y = 10923
   WD = 12300
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000035d0 00002aab 0000300c 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6832
   NAME = <<"B_Ship_to_location2">>
   TAG = 6937
   DISP_ORDER = 25
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 13776
   Y = 9557
   WD = 12300
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000035d0 00002555 0000300c 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6833
   NAME = <<"B_Currency1">>
   TAG = 6937
   DISP_ORDER = 26
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 26568
   Y = 10923
   WD = 3936
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000067c8 00002aab 00000f60 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6834
   NAME = <<"B_Currency2">>
   TAG = 6937
   DISP_ORDER = 27
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 26568
   Y = 9557
   WD = 3936
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000067c8 00002555 00000f60 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6835
   NAME = <<"B_Unit1">>
   TAG = 6937
   DISP_ORDER = 28
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 30996
   Y = 9557
   WD = 3936
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00007914 00002555 00000f60 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6836
   NAME = <<"B_Unit2">>
   TAG = 6937
   DISP_ORDER = 29
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 30996
   Y = 10923
   WD = 3936
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00007914 00002aab 00000f60 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6837
   NAME = <<"B_Invoice_num1">>
   TAG = 6937
   DISP_ORDER = 31
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 4428
   Y = 15019
   WD = 6888
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000114c 00003aab 00001ae8 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6839
   NAME = <<"B_Invoice_num3">>
   TAG = 6937
   DISP_ORDER = 30
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 4428
   Y = 13653
   WD = 6888
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000114c 00003555 00001ae8 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6840
   NAME = <<"B_Invoice_Date1">>
   TAG = 6937
   DISP_ORDER = 32
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 11808
   Y = 15019
   WD = 5904
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002e20 00003aab 00001710 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6841
   NAME = <<"B_Invoice_Date2">>
   TAG = 6937
   DISP_ORDER = 33
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 11808
   Y = 13653
   WD = 5904
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002e20 00003555 00001710 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6842
   NAME = <<"B_Entry_Type1">>
   TAG = 6937
   DISP_ORDER = 34
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 18204
   Y = 13653
   WD = 4920
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000471c 00003555 00001338 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6843
   NAME = <<"B_Entry_Type2">>
   TAG = 6937
   DISP_ORDER = 35
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 18204
   Y = 15019
   WD = 4920
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000471c 00003aab 00001338 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6844
   NAME = <<"B_Qty_Invoiced1">>
   TAG = 6937
   DISP_ORDER = 37
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 23616
   Y = 15019
   WD = 7380
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005c40 00003aab 00001cd4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6845
   NAME = <<"B_Qty_Invoiced2">>
   TAG = 6937
   DISP_ORDER = 36
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 23616
   Y = 13653
   WD = 7380
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00005c40 00003555 00001cd4 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6846
   NAME = <<"B_Inv_price1">>
   TAG = 6937
   DISP_ORDER = 38
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 31488
   Y = 13653
   WD = 8364
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00007b00 00003555 000020ac 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6847
   NAME = <<"B_Inv_price2">>
   TAG = 6937
   DISP_ORDER = 39
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 31488
   Y = 15019
   WD = 8364
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00007b00 00003aab 000020ac 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6848
   NAME = <<"B_PO_FUNCT_PRICE1">>
   TAG = 6937
   DISP_ORDER = 40
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 40344
   Y = 15019
   WD = 6888
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00009d98 00003aab 00001ae8 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6849
   NAME = <<"B_PO_FUNCT_PRICE2">>
   TAG = 6937
   DISP_ORDER = 41
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 40344
   Y = 12288
   WD = 6888
   HT = 2731
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00009d98 00003000 00001ae8 00000aab 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6850
   NAME = <<"B_IPV1">>
   TAG = 6937
   DISP_ORDER = 42
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49912
   Y = 12288
   WD = 7652
   HT = 2731
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c2f8 00003000 00001de4 00000aab 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6851
   NAME = <<"B_IPV2">>
   TAG = 6937
   DISP_ORDER = 43
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 49912
   Y = 15019
   WD = 7652
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000c2f8 00003aab 00001de4 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6852
   NAME = <<"B_Charge_Account1">>
   TAG = 6937
   DISP_ORDER = 44
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 8856
   Y = 16384
   WD = 17220
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002298 00004000 00004344 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6853
   NAME = <<"B_Charge_Account2">>
   TAG = 6937
   DISP_ORDER = 45
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 8856
   Y = 17749
   WD = 17220
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
00002298 00004555 00004344 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6854
   NAME = <<"B_Variance_account1">>
   TAG = 6937
   DISP_ORDER = 46
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 26568
   Y = 17749
   WD = 17220
   HT = 1366
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000067c8 00004555 00004344 00000556 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6855
   NAME = <<"B_Variance_account2">>
   TAG = 6937
   DISP_ORDER = 47
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 26568
   Y = 16384
   WD = 17220
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
000067c8 00004000 00004344 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6940
   NAME = <<"B_ERV1">>
   TAG = 6937
   DISP_ORDER = 79
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 12288
   WD = 7340
   HT = 2731
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e104 00003000 00001cac 00000aab 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6943
   NAME = <<"B_IPV4">>
   TAG = 6937
   DISP_ORDER = 80
   FORMATFLAG = 536871168
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 15019
   WD = 7340
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e104 00003aab 00001cac 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6966
   NAME = <<"B_total_barline1">>
   TAG = 6937
   DISP_ORDER = 83
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57567
   Y = 24576
   WD = 7340
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e0df 00006000 00001cac 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6973
   NAME = <<"B_total_barline3">>
   TAG = 6937
   DISP_ORDER = 86
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 30038
   WD = 7340
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e104 00007556 00001cac 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 36
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6975
   NAME = <<"B_dash1">>
   TAG = 6937
   DISP_ORDER = 89
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 35499
   WD = 7340
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e104 00008aab 00001cac 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6977
   NAME = <<"B_category_total_bar2">>
   TAG = 6937
   DISP_ORDER = 87
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57604
   Y = 32768
   WD = 7340
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e104 00008000 00001cac 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

DEFINE  SRW2_BOILERPLATE
BEGIN
   ITEMID = 6980
   NAME = <<"B_item_total_bar1">>
   TAG = 6937
   DISP_ORDER = 90
   FORMATFLAG = 2048
   PRE_CODE = NULLP
   POST_CODE = NULLP
   X = 57564
   Y = 27307
   WD = 7343
   HT = 1365
   PAGE = 0
   TYPE = 0
   NUM_POINTS = 16
   POINTS = (BINARY)
<<"
0000e0dc 00006aab 00001caf 00000555 
">>
   GRAPH_TYPE = 1
   GRAPH_LFID = (BLONG) NULLP
   GRAPH_LEN = 0
   CLOSE = 0
   MIN_WIDOWS = 1
   MIN_ORPHAN = 0
   MAX_LINES = -1
   TEXT_WRAP = 1
   ALIGNMENT = 4
   ARCFILL = 0
   ARROWSTYLE = 0
   ROTANGLE = 0
   SPACING = 0
   LINKEDFILE = NULLP
   POINTSLFID = (BLONG) NULLP
   OLE_LFID = (BLONG) NULLP
   OLE_LEN = 0
   BIDI_DIR = 0
   ASSOCOBJ = 0
   PERS_FLAGS = 0
   GROUP_NODE = 0
   GN_TYPE = 0
   NULL_IND1 = 0
   NULL_IND2 = 0
   NULL_IND3 = 0
   TEMPL_ID = 0
   FRAME_ID = 0
   ALTXT = NULLP
   HEADERS = NULLP
   LABFIELD = 0
   ACCKEY = NULLP
END

