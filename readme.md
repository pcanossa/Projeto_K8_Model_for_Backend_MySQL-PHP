# Projeto de Deploy: Aplicação Full-Stack com Docker e Kubernetes

Este repositório contém um projeto completo que demonstra o processo de deploy de uma aplicação web de três camadas (Frontend, Backend, Database) utilizando **Docker** para conteinerização e **Kubernetes** para orquestração.

O objetivo é simular um cenário do mundo real, onde o código-fonte é fornecido e o desenvolvedor/DevOps é responsável por criar as imagens, configurar a infraestrutura no cluster e colocar a aplicação no ar de forma automatizada.

## 🏛️ Arquitetura da Aplicação

A aplicação segue uma arquitetura de microsserviços desacoplada:

* **Frontend:** Uma aplicação cliente (ex: um site estático, um app mobile) que consome a API. Neste projeto, ele opera **fora** do cluster Kubernetes.
* **Backend (PHP):** Uma API RESTful responsável pela lógica de negócio. Ela é conteinerizada e gerenciada por um `Deployment` no Kubernetes para garantir alta disponibilidade e escalabilidade.
* **Database (MySQL):** Um banco de dados relacional para persistir os dados da aplicação. Também é conteinerizado e gerenciado por um `Deployment` com persistência de dados.

O fluxo de comunicação é o seguinte:
`Cliente Externo` ➡️ `Service (LoadBalancer)` ➡️ `Pods do Backend (PHP)` ➡️ `Service (ClusterIP)` ➡️ `Pod do Database (MySQL)`

## 🛠️ Tecnologias Utilizadas

* **Conteinerização:** Docker
* **Orquestração:** Kubernetes (Minikube para ambiente local ou GKE/EKS/AKS para nuvem)
* **Backend:** PHP 7.4 + Apache
* **Banco de Dados:** MySQL 5.7
* **CI/CD:** Scripts de automação (`.sh`, `.bat`) para build, push e deploy.

## 📂 Estrutura do Repositório

/
├── backend/         # Contém o Dockerfile e o código-fonte da aplicação PHP.
├── database/        # Contém o Dockerfile e o script de inicialização do MySQL.
├── deployment.yml   # Manifesto K8s para os Deployments do backend e database.
├── service.yml      # Manifesto K8s para os Services (LoadBalancer e ClusterIP).
├── script.sh        # Script de automação para Linux/macOS.
└── script.bat       # Script de automação para Windows.

## 🚀 Como Executar o Projeto

Siga os passos abaixo para colocar a aplicação no ar.

### Pré-requisitos

* **Docker** instalado e em execução.
* **Kubernetes Cluster** acessível (ex: Minikube iniciado ou cluster na nuvem configurado).
* **`kubectl`** instalado e configurado para apontar para o seu cluster.
* **Conta no Docker Hub** (ou outro container registry) para hospedar as imagens.

### Passos para o Deploy

1.  **Clone o Repositório**
    ```bash
    git clone [URL_DO_SEU_REPOSITORIO]
    cd [NOME_DO_REPOSITORIO]
    ```

2.  **⚠️ IMPORTANTE: Configure seu Usuário**
    Antes de executar, você **precisa** substituir todas as ocorrências de `seu-username` nos seguintes arquivos pelo seu nome de usuário real do Docker Hub:
    * `script.bat`
    * `script.sh`
    * `deployment.yml`

3.  **Faça Login no Docker**
    Autentique-se no seu container registry.
    ```bash
    docker login
    ```

4.  **Execute o Script de Automação**
    O script irá cuidar de todo o processo: build das imagens, push para o registry e aplicação dos manifestos no Kubernetes.

    * **No Windows:**
        ```batch
        .\script.bat
        ```
    * **No Linux/macOS:**
        ```bash
        chmod +x script.sh
        ./script.sh
        ```

5.  **Verifique o Deploy**
    Aguarde alguns minutos para que todos os recursos sejam criados e os Pods fiquem no estado `Running`.

    * **Verificar os Pods:**
        ```bash
        kubectl get pods
        ```
        Você deverá ver 1 Pod do MySQL e as réplicas do Pod do backend.

    * **Verificar os Serviços e Obter o IP Externo:**
        ```bash
        kubectl get services
        ```
        Procure pelo serviço `backend-loadbalancer`. Na coluna `EXTERNAL-IP`, você encontrará o endereço IP para acessar sua aplicação.
        *(No Minikube, pode ser necessário executar `minikube service backend-loadbalancer` para obter a URL de acesso).*

6.  **Conecte o Frontend**
    Use o `EXTERNAL-IP` obtido no passo anterior para configurar a URL da API no seu frontend e testar a aplicação.

## 📜 Scripts de Automação

Os scripts `script.sh` e `script.bat` automatizam as seguintes etapas:
1.  **Build das Imagens:** Cria as imagens Docker customizadas para o backend e para o database.
2.  **Push das Imagens:** Envia as imagens recém-criadas para o seu repositório no Docker Hub.
3.  **Deploy dos Serviços:** Aplica o `service.yml` para criar os endpoints de rede.
4.  **Deploy das Aplicações:** Aplica o `deployment.yml` para criar os Pods do backend e do database.

## 👤 Autor

Este projeto foi desenvolvido como parte da trilha de estudos da [Digital Innovation One](https://www.dio.me/), com base no curso ministrado por **Denilson Bonatti**.