# albumDiscovery
Sample project showcasing architecture, libraries that I like to use while developing. App is able to search artists and their's albums and save them localy It uses Lastfm public API.

# Tools
Networking is implemented using [Alamofire](https://github.com/Alamofire/Alamofire), response parsing is done using Codable protocol

Application is implemented using MVVM architecture reactive way using [Bond](https://github.com/DeclarativeHub/Bond) to bind viewModel state to view part.

For storage I prefer using [Realm](https://realm.io/) because of simplicity of use, and it is much faster than CoreDate, also it supports encryption out of box
