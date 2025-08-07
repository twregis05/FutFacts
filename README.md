# FutFacts

Original App Design Project
===

# FutFacts

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)

## Overview

### Description

FutFacts is an app that provides the user with real-time data on players, teams, and leagues from Europe's top 5 soccer leagues! It will allow users to follow their favorite players and teams, as well as compare and contrast stats. 

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:**
- **Mobile:**
    - Real-time data, portable stats
    - Don't need to use a web browser and try to view data (can be tedious on mobile)
- **Story:**
    - Many people use similar apps (i.e. OneFootball), many of which don't directly compare players/teams 
    - Many of my peers would think this would be an interesting app to have!
- **Market:**
    - Soccer fans (global fanbase; HUGE!)
- **Habit:**
    - Moreso addicting than habit forming, but most wouldn't become addicted to an app like this
    - Average user would likely open the app twice a week for less than 30 minutes each day
    - Could fluctuate depending on transfer news/deadline day
- **Scope:**
    - Somewhat difficult to do
    - Need to pull stats from API
    - Need to incorporate user login
    - Potential incorporation of data visualization
    - This can be mostly done if significant work is done within the next week

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in
* User can sign up
* User can log out
* User can edit their account preferences
    * Username
    * Profile Picture
    * Favorite team
* User can follow players, teams and leagues
* User can see player and team data

**Optional Nice-to-have Stories**

* User can compare players/teams with each other
* User can view data visualizations of players
* User can view and interact with league tables
- [x] User can use app in both light mode and dark mode

### 2. Screen Archetypes

* Login Screen
    * User can log in
* Sign up Screen
  * User can sign up
* Detail Screen (account)
    * User can edit their account preferences
    * User can log out 
* Following screen
    * User can follow players, teams and leagues
* Search
    * User can follow players, teams, and leagues
* Detail Screen (player, team)
    * User can see player and team data
    * **Stretch**
        * User can view data visualizations of players
        * User can compare players/teams with each other
* Detail Screen (league)
    * User can interact with league tables
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home feed
* Account/Settings
* Following page

**Flow Navigation** (Screen to Screen)

- Login Screen
    * => Home
    * => Sign up
- Sign up screen
    * => Log in
- Home Screen 
    * => Search screen
    * => team detail screen (potentially)
    * => player detail screen (potentially)
- Search Screen
    * => Player detail screen
    * => Team detail screen
    * => Home screen (return)
* Team detail screen
    * => Player detail screen
    * => Search screen (return)
    * => Home screen (return)
* Player detail screen
    * => Team detail screen
    * => Search screen (return)
    * => Home screen (return)
* Following screen
    * => Player detail screen
    * => Team detail screen
    * => Search screen (maybe)
* Account/Settings screen
    * => Login screen 

## Wireframes
<img width="2157" height="1668" alt="image" src="https://github.com/user-attachments/assets/ac2286df-5d73-4d01-953e-eadc48c42055" />



### Networking

- Football API
- Strech:
    - Ticketmaster API
    - YouTube API
    - OpenAI API

## What's been done so far:
- [x] User can use app in light and dark mode
- [x] App navigation generally set up
- [x] Home, Login, Sign up, Following, and Account page initial set up
- [x] Created app logo

**What needs to be done (hopefully by next week)**
- [ ] Integrate Football API to get soccer stats
- [ ] Add more pages to display these stats
- [ ] Set up login/sign up logic
    - [ ] Set up MongoDB integration with Swift
- [ ] Implement account screen to adjust user preferences 


## Video Demo
<div>
    <a href="https://www.loom.com/share/918cc26d35314196a9f20f6748653549">
      <p>FutFacts - Initial Video Demo - Watch Video</p>
    </a>
    <a href="https://www.loom.com/share/918cc26d35314196a9f20f6748653549">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/918cc26d35314196a9f20f6748653549-8f34acb6ce9221f7-full-play.gif">
    </a>
  </div>
