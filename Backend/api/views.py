from rest_framework import viewsets
from .models import detalles_pedidos,detalles_productos,detalles_promociones,productos,pedidos,promociones
from .serializer import detalles_pedidosSerializer,detalles_productosSerializer,detalles_promocionesSerializer,productosSerializer, pedidosSerializer, promocionesSerializer

class detalles_pedidosViewSet(viewsets.ModelViewSet):
	queryset = detalles_pedidos.objects.all()
	serializer_class = detalles_pedidosSerializer

class detalles_productosViewSet(viewsets.ModelViewSet):
	queryset = detalles_productos.objects.all()
	serializer_class = detalles_productosSerializer

class detalles_promocionesViewSet(viewsets.ModelViewSet):
	queryset = detalles_promociones.objects.all()
	serializer_class = detalles_promocionesSerializer

class productosViewSet(viewsets.ModelViewSet):
	queryset = productos.objects.all()
	serializer_class = productosSerializer

class pedidosViewSet(viewsets.ModelViewSet):
	queryset = pedidos.objects.all()
	serializer_class = pedidosSerializer

class promocionesViewSet(viewsets.ModelViewSet):
	queryset = promociones.objects.all()
	serializer_class = promocionesSerializer




# class tbl_clienteViewSet(viewsets.ModelViewSet):
# 	queryset = tbl_cliente.objects.all()
# 	serializer_class = tbl_clienteSerializer

# class tbl_rolViewSet(viewsets.ModelViewSet):
# 	queryset = tbl_rol.objects.all()
# 	serializer_class = tbl_rolSerializer
 





