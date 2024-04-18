from django.contrib import admin
from .models import tbl_cliente,tbl_rol

admin.site.register(detalles_pedidos)
admin.site.register(detalles_productos)
admin.site.register(detalles_promociones)
admin.site.register(productos)
admin.site.register(pedidos)
admin.site.register(promociones)

# Register your models here.
# admin.site.register(tbl_cliente)
# admin.site.register(tbl_rol)

