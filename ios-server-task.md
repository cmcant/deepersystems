# Overview

A friend wants a private photo taking app on his iOS device. He doesn't trust the cloud or any company but he trusts you to make this app for him.

# Task

The task has two parts: the server and the app.

## Server

The server should have three endpoints:

- upload a photo
- list photos
- download a photo

It should be written in Python but you can use any technology or framework you want. We recommend Flask if you don't have a preference.

Your app is the only thing that will use the server so it can be in whatever simplest way for the app to use.

## App

The app should have this functionality:

- take a photo, it uploads it to server
- list photo filenames from the server
- click on a photo filename in the list to view the existing photo

# Deliverable

A working server and app. Set up the server somewhere (you can use [ngrok](https://ngrok.com/) to run it from your machine), and send us an app that can work on UDID `d49f08d808b38da69956098c1e73830e90f60d08`. I believe you can send the signed app via TestFlight via e-mail, to claudiu@deepersystems.com .

Note that if there is an easier way for us to test the app we are open to suggestions :).


## Server

cd server
./manage.py runserver
Link API
http://201.76.149.210:8002

## API - Image
[![Image APP]([![Image APP](https://github.com/cmcant/deepersystems/blob/master/imgapp.jpg)]
)]

## Client

## APP - Image

[![Image APP](https://github.com/cmcant/deepersystems/blob/master/imgapp.jpg)]

## APP - Video


[![Video APP](https://github.com/cmcant/deepersystems/blob/master/V%C3%ADdeo.MOV)]


