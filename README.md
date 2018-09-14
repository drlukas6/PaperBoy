
# PaperBoy

A Place For All Your Dailies. Fetch news from over 30.000 sources with just a tap!👆


![enter image description here](https://s8.postimg.cc/oor4640kl/Screenshot_2018-09-14_at_10.26.28.png)

## Features

- Multiple in-app accounts 👥
- Per-category browsing 🌍 
- Reactive article search 🔭
- Level-up system 🎈
- Saving articles 📥
- 🎆**outrun** color scheme🎇

## Requirements

- iOS 11.0+

## To Implement 🔜
- Keychain validation 🔐 
- Local push notifications 📲 
- Better leveling up equation 

## Installation

1. Pull Master branch 
2. `pod install` to create *.workspace
3. Build and run the PaperBoy.workspace

# TrapperKeeper

🎩 A quite simple internet networking tool built to reduce outsourced dependencies 🎩

## Features
- Performing simple requests from the web 
- Decoding fetched data as either a JSON or an Image
- Ease of use
- Default values

## Usage

requestJSON(url: URL, method: HTTPMethod, headers: [String : String], parameters: [String : Any], closure: @escaping ([String : Any], Error?) -> Void)
requestImage(url: URL, closure: @escaping (UIImage?) -> Void)
requestData(url: URL, method: HTTPMethod, headers: [String : String], parameters: [String : Any], closure: @escaping (Data, Error?) -> Void)

