from rest_framework import viewsets
from .models import tbl_cliente,tbl_rol
from .serializer import tbl_clienteSerializer,tbl_rolSerializer

class tbl_clienteViewSet(viewsets.ModelViewSet):
	queryset = tbl_cliente.objects.all()
	serializer_class = tbl_clienteSerializer

class tbl_rolViewSet(viewsets.ModelViewSet):
	queryset = tbl_rol.objects.all()
	serializer_class = tbl_rolSerializer
 





