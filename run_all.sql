--------------------------------------------------------------------------------
-- Restaurant DB & Data Warehouse - Master Build Script (run in SQL*Plus / SQLcl)
-- Usage: sqlplus user/pass@db @run_all.sql
--------------------------------------------------------------------------------
SET DEFINE OFF
SET SERVEROUTPUT ON

@database/tables.sql
@procedures/functions.sql
@procedures/procedures.sql
@procedures/triggers.sql
@database/sample_data.sql
@data_warehouse/warehouse.sql
@data_warehouse/analytical_queries.sql

PROMPT ============================================
PROMPT Build complete: OLTP schema + sample data + warehouse
PROMPT ============================================
