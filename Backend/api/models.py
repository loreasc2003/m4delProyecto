from django.db import models
from django.utils import timezone


class detalles_pedidos(models.Model):
    id = models.AutoField(primary_key=True)
    pedido_id = models.IntegerField()
    producto_id = models.IntegerField()
    cantidad = models.PositiveIntegerField()
    total_parcial = models.DecimalField(max_digits=10, decimal_places=2)
    fecha_registro = models.DateTimeField(auto_now_add=True)
    fecha_entrega = models.DateTimeField()
    estatus = models.CharField(max_length=20)

    def __str__(self):
        return f"Detalle de pedido {self.id}"

		
class detalles_productos(models.Model):
    id = models.AutoField(primary_key=True)
    producto_id = models.IntegerField()
    descripcion = models.TextField()
    codigo_barras = models.CharField(max_length=50)
    presentacion = models.CharField(max_length=100)
    productos_existencia = models.PositiveIntegerField()
    estatus = models.CharField(max_length=20)

    def __str__(self):
        return f"Detalle del producto {self.id}"

class detalles_promociones(models.Model):
    id = models.AutoField(primary_key=True)
    promociones_id = models.IntegerField()
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    estatus = models.CharField(max_length=20)

    def __str__(self):
        return f"Detalle de la promoción {self.id}"

class productos(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    marca = models.CharField(max_length=100)
    precio_actual = models.DecimalField(max_digits=10, decimal_places=2)
    fotografia = models.ImageField(upload_to='productos/')
    estatus = models.CharField(max_length=20)

    def __str__(self):
        return self.nombre

class pedidos(models.Model):
    id = models.AutoField(primary_key=True)
    usuario_id = models.IntegerField()
    producto_id = models.IntegerField()
    total = models.DecimalField(max_digits=10, decimal_places=2)
    fecha_registro = models.DateTimeField(auto_now_add=True)
    estatus = models.CharField(max_length=20)

    def __str__(self):
        return f"Pedido {self.id}"

class promociones(models.Model):
    id = models.AutoField(primary_key=True)
    producto_id = models.IntegerField()
    tipo = models.CharField(max_length=50)
    aplicacion_en = models.CharField(max_length=50)
    estatus = models.CharField(max_length=20)

    def __str__(self):
        return f"Promoción {self.id}"



# class tbl_cliente(models.Model):
# 	d_nombre = models.CharField(max_length=50)
# 	d_apellidoPaterno = models.CharField(max_length=50)
# 	d_apellidoMaterno = models.CharField(max_length=50)
# 	d_direccion = models.CharField(max_length=150)
# 	d_telefono = models.CharField(max_length=15)
# 	d_correo = models.CharField(max_length=100)
# 	d_contrasena = models.CharField(max_length=50)
# 	#website = models.URLField(max_length=100)
# 	#foundation = models.PositiveIntegerField()
#     #TextField(blanck=True)
# 	def __str__(self):
# 		return self.d_nombre
	
# class tbl_rol(models.Model):
# 	ro_nombre = models.CharField(max_length=50)
# 	#website = models.URLField(max_length=100)
# 	#foundation = models.PositiveIntegerField()
#     #TextField(blanck=True)
# 	def __str__(self):
# 		return self.ro_nombre
