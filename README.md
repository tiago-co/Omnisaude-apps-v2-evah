# Aplicativos `White Label` dos clientes da OmniSaúde.

A arquitetura está montada para acoplar e desacoplar dependências de acordo com as necessidades de cada aplicativo, bastando adicionar ao `pubspec.yaml` os módulos que serão utilizados por ele.

# Para executar os aplicativos

* Criar e atualizar o arquivo `.env`, de acordo com o `.env.example`:

``` dart
BASE_URL = base_url
PROD_BASE_URL = prod_base_url
HOMOL_BASE_URL = homol_base_url
IMPL_BASE_URL = impl_base_url
DEV_BASE_URL = dev_base_url
AGORA_APP_ID = agora_app_id;
WSS_URL = wss_url
POWERED_BY = powered_by
API = api
TIMEOUT = 0
```

* Instalar o versionador de versão do `Flutter`:

``` https
https://github.com/leoafarias/fvm
```

* Após instalar o `FVM`, configurar a versão do flutter utilizada:

```
fvm flutter use 2.10.5 --force
```
PS.: Verificar as configurações de cada IDE para utilizar o `FVM` fora da linha de comando.

* No diretório do aplicativo específico, atualizar as dependências do mesmo:

```
fvm flutter pub get
```

# Contato

Para mais informações, entrar em contato.

```
tiago@omnisaude.life
```
