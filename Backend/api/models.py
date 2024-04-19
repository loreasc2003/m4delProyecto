from django.db import models



class detalles_pedidos(models.Model):
    id = models.AutoField(primary_key=True)
    pedido_id = models.IntegerField()
    producto_id = models.IntegerField()
    cantidad = models.PositiveIntegerField()
    total_parcial = models.DecimalField(max_digits=10, decimal_places=2)
    fecha_registro = models.DateTimeField(auto_now_add=True)
    fecha_entrega = models.DateTimeField()
    estatus = models.BooleanField(default=False) 

    class Meta:
        db_table = 'detalles_pedidos'
    

		
class detalles_productos(models.Model):
    id = models.AutoField(primary_key=True)
    producto_id = models.IntegerField()
    descripcion = models.TextField()
    codigo_barras = models.IntegerField()
    presentacion = models.CharField(max_length=100)
    productos_existencia = models.PositiveIntegerField()
    estatus = models.BooleanField(default=False) 

    class Meta:
        db_table = 'detalles_productos'

class detalles_promociones(models.Model):
    id = models.AutoField(primary_key=True)
    promociones_id = models.IntegerField()
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    estatus = models.BooleanField(default=False) 

    class Meta:
        db_table = 'detalles_promociones'

class productos(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    marca = models.CharField(max_length=100)
    precio_actual = models.DecimalField(max_digits=10, decimal_places=2)
    fotografia = models.ImageField(upload_to='productos/')
    estatus = models.BooleanField(default=False) 

    class Meta:
        db_table = 'productos'

class pedidos(models.Model):
    id = models.AutoField(primary_key=True)
    usuario_id = models.IntegerField()
    producto_id = models.IntegerField()
    total = models.DecimalField(max_digits=10, decimal_places=2)
    fecha_registro = models.DateTimeField(auto_now_add=True)
    estatus = models.BooleanField(default=False) 

    class Meta:
        db_table = 'pedidos'

class promociones(models.Model):
    id = models.AutoField(primary_key=True)
    producto_id = models.IntegerField()
    TIPO_CHOICES = (
        ('membresias', 'Membresías'),
        ('personalizado', 'Personalizado'),
        ('complementarios', 'Complementarios'),
        ('recompensas', 'Recompensas'),
    )
    tipo = models.CharField(max_length=15, choices=TIPO_CHOICES)
    APLICACION_CHOICES = (
        ('Membresia', 'Membresía'),
        ('Producto', 'Producto'),
    )
    aplicacion_en = models.CharField(max_length=10, choices=APLICACION_CHOICES)
    estatus = models.BooleanField(default=False) 

    class Meta:
        db_table = 'promociones'



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
