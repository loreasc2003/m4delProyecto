from rest_framework import serializers
from .models import detalles_pedidos,detalles_productos,detalles_promociones,productos, pedidos, promociones

class detalles_pedidosSerializer(serializers.ModelSerializer):
	class Meta:
		model = detalles_pedidos
		fields = '__all__'

class detalles_productosSerializer(serializers.ModelSerializer):
	class Meta:
		model = detalles_productos
		fields = '__all__'

class detalles_promocionesSerializer(serializers.ModelSerializer):
	class Meta:
		model = detalles_promociones
		fields = '__all__'

class productosSerializer(serializers.ModelSerializer):
	class Meta:
		model = productos
		fields = '__all__'

class pedidosSerializer(serializers.ModelSerializer):
	class Meta:
		model = pedidos
		fields = '__all__'

class promocionesSerializer(serializers.ModelSerializer):
	class Meta:
		model = promociones
		fields = '__all__'


# class tbl_clienteSerializer(serializers.ModelSerializer):
# 	class Meta:
# 		model = tbl_cliente
# 		fields = '__all__'
		
# class tbl_rolSerializer(serializers.ModelSerializer):
# 	class Meta:
# 		model = tbl_rol
# 		fields = '__all__'
