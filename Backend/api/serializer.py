from rest_framework import serializers
from .models import tbl_cliente,tbl_rol

class tbl_clienteSerializer(serializers.ModelSerializer):
	class Meta:
		model = tbl_cliente
		fields = '__all__'
		
class tbl_rolSerializer(serializers.ModelSerializer):
	class Meta:
		model = tbl_rol
		fields = '__all__'
