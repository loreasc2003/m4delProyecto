from django.urls import path,include
from rest_framework import routers
from api import views

router = routers.DefaultRouter()
router.register(r'detalles_pedidos', views.detalles_pedidosViewSet)
router.register(r'detalles_productos', views.detalles_productosViewSet)
router.register(r'detalles_promociones', views.detalles_promocionesViewSet)
router.register(r'productos', views.productosViewSet)
router.register(r'pedidos', views.pedidosViewSet)
router.register(r'promociones', views.promocionesViewSet)

urlpatterns = [
	path('api/v1',include(router.urls))
]

