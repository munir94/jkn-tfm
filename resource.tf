module "rg-jenkin" {
    source = "./modules/rg"
    rgname = "jenkin"
    region = "southeastasia"
}

#CALL VNET MODULE
 module "vnet-jenkin" {
  source         = "./modules/network/vnet"
  vnet-rg        = module.rg-jenkin.rgname
  vnet-name      = "JK-VNET"
  vnet-range     = ["192.168.16.0/24","172.16.0.0/22"]
  subnets-name   = ["subnet01","subnet02"]
  subnets-range  = ["192.168.16.0/28","172.16.0.0/24"]
  vnet-location  = module.rg-jenkin.region
  depends_on = [
    module.rg-jenkin
  ]
 }
#CALL Windows VM  MODULE
module "winvm-jenkin" {
  source = "./modules/compute/WinVM"
  vmname = "JKTFMVM"
  subnet_id = module.vnet-jenkin.vnet_subnets.0
//refer to output from rg
 vmrg = module.rg-jenkin.rgname
 rgloc = module.rg-jenkin.region

  depends_on = [
    module.rg-jenkin
  ]
}