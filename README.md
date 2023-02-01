</br></br>

<div align="right">
<i>
By Alexandre De Freitas Martins, Antoine Frankel & Philippe Cheype - Epitech Nice - 2023
</i>
</div>****
</br></br>

<div align="center">
    <h1>
        <div>
            Workshop Directus
            </br></br>
            Authentification et routes
        </div>
    </h1>
    <img src="assets/epitech_logo.png" alt="Epitech" height="75" />
</div>

</br></br>

## Before starting

If you want to be present you need send an email to alexandre-kevin.de-freitas-martins@epitech.eu with the following object:

```
[WSDirectus] Nom Prénom
```

Or you can Fork the repository and make a pull request with the same syntax.

⚠️ Put your real firstname and lastname ⚠️ \
In the mail share a `.zip` or `.tar.gz` file with the contents of your repository. \
⚠️ Please assure you that the repository is clean before compressing it⚠️

Any work you do needs to be in the email, if you don't do this or didn't advance into the workshop at all you will be marked absent.

## Introduction

Directus is a headless CMS that provides a simple and intuitive interface to manage your content and files, making it easy to integrate with any platform that you are using.

## Requirements

### Installation

#### 1. Download Docker

```
https://docs.docker.com/engine/install/fedora/

    Or see

https://www.docker.com/products/docker-desktop
```

#### 2. Download NPM

```
sudo dnf install nodejs

    Or see

https://www.npmjs.com/get-npm
```

#### 3. Download YARN

```
sudo dnf install yarnpkg

    Or see

https://classic.yarnpkg.com/en/docs/install/#debian-stable
```

#### 4. Download NVM

```
https://garywoodfine.com/install-nvm-node-version-manager-fedora/

    Or see

https://github.com/nvm-sh/nvm
```
#### 5. Download MySQL
```
sudo dnf update
sudo dnf install community-mysql-server -y

For other OS see:
https://dev.mysql.com/downloads/mysql/
```

#### 6. Install Directus
```
npm install -g create-directus-project

yarn global add create-directus-project
```

## Configuration
Go to the root of the project and run the following command:
```bash
ln -s docker/docker-compose.local.yml docker-compose.yml
docker compose up -d # or: docker-compose up -d

cd ./bin
./restore.sh

cd ../directus
ln -s env/.env.local .env
yarn install
npx directus start
```

If you get an error:
```bash
cd extensions/endpoints/workshop-endpoint

yarn install
yarn dev
```

Now that you have directus up and running take a look at the left navigation bar:

|  |  |
|-:|:-|
| <img src="assets/nav_bar.png" alt="Nav bar" width="50" /> | 1. Content<br/>2. User directory<br/>3. File Library<br/>4. Insight<br/>5. Documentation<br/>6. Settings |



In order we

### 1. Database

Your database consists of two main parts:
- In `6. Settings` > `Data model` you can set up your models and the fields that they contain.
- In `1. Content` you can populate your models with data.

### 2. Routes / Endpoints

Routes are a path inside your API that will lead to a specific model. These can be `GET` (get information), `POST` (add information), `DELETE` (delete information), ...

For example if you have a model called `users` and you want to get all the users you can go to `localhost:8055/users` and you will get a JSON with all the users.

Your routes are automatically created from the models you set up in your database. You can also create [custom API routes](https://docs.directus.io/extensions/endpoints.html)

## Usage

Let's go step by step trough directus.

### 1. Login

Start by runnig your local server. Then go to `localhost:8055` and login with the following credentials:
- Username: `support@workshop.com`
- Password: `1234567890`

### 2. Create a Collection

Go to `6. Settings` > `Data model` and click on `Create collection`.


__/!\ Fields are case sensitive be careful when naming them__

Name it `dogs` and click on `Next`.

### 3. Add Fields

Now you have the choice of adding custom fields. You can select `Created on` and click on `Finish Setup`.

Your collection is now created with the default field `id` and the extra field `date_created`.

- Create a new field `Input` (in category `Text & Numbers`), set the key to `breed`.
- Create a new field `Input` (in category `Text & Numbers`), set the key to `name`.
- Create a new field `Image` (in category `Relational`), set the key to `image`.

### 4. Add Data

Let's now add dogs to our collection. Go to `1. Content` > `dogs` and click on `Create item`.

Fill in the fields:
- breed: `bulldog`
- name: `Admiral`
- image: Upload an image of a bulldog by dragging it in the field.

Now click on `Save`

Add about 6 new dogs, try to make two of them the same breed, this will help in demonstrating the API filtering later.

### 5. Add a File

You can also add files to your file library. Go to `3. File Library` and click on `Upload file`.

### 6. Add a Role

Go to `6. Settings` > `Roles & Permissions` and click on `Create role`. Name it `Dog Master` and click `Save`

Give this role create/read/write/delete permissions on the `dogs` collection.

### 6. Add a User

Go to `2. User directory` and click on `Create item`.

Give the new user a name and at the bottom in the `Admin Options` section select the role `Dog Master`.

## API

### 1. Get all dogs

Go to `localhost:8055/dogs` and you will get a JSON with all the dogs.

### 2. Get a specific dog

Go to `http://localhost:8055/dogs?fields=*.*&filter[name][eq]=Admiral` and you will get a JSON with the dog Admiral.

### 3. Get all dogs of a specific breed

Go to `http://localhost:8055/dogs?fields=*.*&filter[breed][eq]=bulldog` and you will get a JSON with all the dogs of the breed bulldog.

### 4. Get all dogs of a specific breed and name

Go to `http://localhost:8055/dogs?fields=*.*&filter[breed][eq]=bulldog&filter[name][eq]=Admiral` and you will get a JSON with all the dogs of the breed bulldog and name Admiral.

You get the point, the API is very flexible.
