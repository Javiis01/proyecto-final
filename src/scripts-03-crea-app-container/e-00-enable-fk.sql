ALTER TABLE EMPLEADO ENABLE CONSTRAINT FK_VETERINARIA_EMPLEADO;
ALTER TABLE VETERINARIA ENABLE CONSTRAINT FK_VENDEDOR_VETERINARIA;
ALTER TABLE INVENTARIO_VETERINARIA ENABLE CONSTRAINT FK_ESTATUSPROD_INVENTARIOVETERINARIA;
ALTER TABLE HISTORICO_ESTATUS_PRODUCTOS ENABLE CONSTRAINT FK_ESTATUSPRODUCTO_HISTORICOESTATUSPROD;

-- Habilitando las FKS
alter table pet_care_admin.empleado enable constraint fk_veterinaria_empleado;
alter table pet_care_admin.veterinaria enable constraint fk_vendedor_veterinaria;
alter table pet_care_admin.inventario_veterinaria enable constraint fk_estatusprod_inventarioveterinaria;
alter table pet_care_admin.historico_estatus_productos enable constraint fk_estatusproducto_historicoestatusprod;

-- Desahibilitando las FK
alter table pet_care_admin.empleado disable constraint fk_veterinaria_empleado;
alter table pet_care_admin.veterinaria disable constraint fk_vendedor_veterinaria;
alter table pet_care_admin.inventario_veterinaria disable constraint fk_estatusprod_inventarioveterinaria;
alter table pet_care_admin.historico_estatus_productos disable constraint fk_estatusproducto_historicoestatusprod;