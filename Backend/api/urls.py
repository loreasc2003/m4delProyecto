from django.urls import path,include
from rest_framework import routers
from api import views

router = routers.DefaultRouter()
router.register(r'tbl_cliente', views.tbl_clienteViewSet)
router.register(r'tbl_rol', views.tbl_rolViewSet)

urlpatterns = [
	path('api/v1',include(router.urls))
]

