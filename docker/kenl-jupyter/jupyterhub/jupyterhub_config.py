#c = get_config()

c.JupyterHub.log_level = 10

c.Authenticator.whitelist = {'kenladmin', 'kenladmin2', 'kenladmin3'}
c.Authenticator.admin_users = {'kenladmin'}
c.Spawner.cmd = ['jupyter-labhub']
c.Spawner.notebook_dir = '/opt/kenl/jupyterhub'

c.JupyterHub.hub_ip = 'kenl-jupyter'
c.JupyterHub.port = 8000
c.JupyterHub.hub_port = 8181

c.JupyterHub.base_url = '/jupyter'