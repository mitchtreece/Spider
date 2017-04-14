![Spider](Resources/logo.png)

[![Version](https://img.shields.io/cocoapods/v/Spider.svg?style=flat)](http://cocoapods.org/pods/Spider)
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/Spider.svg?style=flat)](http://cocoapods.org/pods/Spider)
[![License](https://img.shields.io/cocoapods/l/Spider.svg?style=flat)](http://cocoapods.org/pods/Spider)

## Overview
Spider is an easy-to-use web framework built on-top the wonderful [AFNetworking](https://github.com/AFNetworking/AFNetworking) library. Spider's easy syntax & modern response handling makes requesting data incredibly simple.

## Installation
### CocoaPods
Spider is integrated with CocoaPods!

1. Add the following to your `Podfile`:
```
use_frameworks!
pod 'Spider'
```
2. In your project directory, run `pod install`
3. Import the `Spider` module wherever you need it
4. Profit

### Manually
You can also manually add the source files to your project.

1. Clone this git repo
2. Add all the Swift files in the `Spider/` subdirectory to your project
3. Profit

## The Basics

Spider can be used in many different ways. Many times, a shared (one-off) approach is all that's needed.

```Swift
Spider.web.get("https://path/to/endpoint") { (response) in
    print("We got a response!")
}
```

This simply makes a `GET` request with a given path & parameters, and returns a `SpiderResponse` object.

### SpiderResponse

The `SpiderResponse` object is really just a fancy typealias over an even fancier tuple. It's defined as:

```Swift
public typealias SpiderResponse = (res: URLResponse?, data: Any?, err: Error?)
```

It contains 3 optional objects. The `URLResponse` object (_res_), response data (_data_), and an error object (_err_). Easy to use & understand, plus it helps keep our code readable! Hooray!

### Base URLs

Because we typically make more than one request to a given API, using _base URLs_ just makes sense. This is also useful when we need to switch between versions of API's (i.e. dev, pre-prod, prod, etc...).

```Swift
let baseUrl = URL(string: "https://base.url/v1")!
let spider = Spider.web(withBaseUrl: baseUrl)

spider.get("/users") { (response) in
    print("We got a response!")
}

spider.get("/locations") { (response) in
    print("We got another response!")
}
```

Notice how we can now make requests to specific endpoints with the same shared base url. The above requests would hit the endpoints:

```
https://base.url/v1/users
https://base.url/v1/locations
```

If a base url is not specified, Spider will assume the `path` of your request is a fully qualified url (as seen in the first example).

### Request Parameters

All variations of `SpiderRequest` instantiation have a means for you to pass in request parameters. For example:

```Swift
let params = ["user_id": "123456789"]
Spider.web.get("https://path/to/endpoint", parameters: params) { (response) in
    print("We got a response!")
}
```

This will take your parameters and pass them along in the request's body.

### Spider Instances

So far, we have been working with the shared (global) instance of Spider. This is usually all you need. Just in case you need more control, Spider also supports a more typical instantiation flow.

```Swift
let tarantula = Spider()
tarantula.get("https://path/to/endpoint") { (response) in
    print("Tarantula got a response!")
}
```

Instead of using the shared Spider instance, we created our own instance named _tarantuala_ and made a request with it. Spooky! Naturally, Spider instances created like this also support base urls:

```Swift
let baseUrl = URL(string: "https://base.url/v1")!
let blackWidow = Spider(baseUrl: baseUrl)
blackWidow.get("/users") { (response) in
    print("Black Widow got a response!")
}
```

### Advanced Requests

Spider also supports advanced request options. You can configure and perform a `SpiderRequest` manually like this:

```Swift
let request = SpiderRequest(method: .get, path: "https://path/to/endpoint", parameters: nil)
request.header.accept = [.image_jpeg, .custom("custom_accept_type")]
request.header.set(value: "12345", forHeaderField: "user_id")

Spider.web.perform(request) { (response) in
    print("We got a response!")
}
```

### Authorization

Currently, Spider supports the following authorization types:
- Basic (user:pass base64 encoded)
- Token

Authorization can be added on a per-request or instance-based basis. Typically we would want to provide our Spider instance authorization that all requests would be sent with:

```Swift
let auth = TokenAuth(value: "0123456789")
let baseUrl = URL(string: "https://base.url/v1")!
let bigHairySpider = Spider.web(withBaseUrl: baseUrl, auth: .token(auth))
bigHairySpider.get("/topSecretData") { (response) in
    print("Big hairy spider got a response!")
}
```

However, authorization can also be provided on a per-request basis if it better fits your situation:

```Swift
let auth = TokenAuth(value: "0123456789")
let baseUrl = URL(string: "https://base.url/v1")!
let aSpider = Spider.web(withBaseUrl: baseUrl)
aSpider.get("/topSecretData", auth: .token(auth)) { (response) in
    print("Spider got a response!")
}
```

Advanced requests can also provide authorization:

```Swift
let auth = TokenAuth(value: "0123456789")

let request = SpiderRequest(method: .get, path: "https://path/to/endpoint")
request.header.accept = [.image_jpeg, .custom("custom_accept_type")]
request.header.set(value: "12345", forHeaderField: "user_id")
request.auth = .token(auth)

Spider.web.perform(request) { (response) in
    print("We got a response!")
}
```

By default, auth is added to the _"Authorization"_ header field of your request. This can be changed by passing in a custom field when creating the auth:

```Swift
let auth = BasicAuth(username: "root", password: "pa55w0rd", headerField: "Credentials")
let baseUrl = URL(string: "https://base.url/v1")!
let charlotte = Spider.web(withBaseUrl: baseUrl, auth: .basic(auth))
charlotte.get("/topSecretData") { (response) in
    print("Charlotte got a response!")
}
```

The authorization _type_ can also be customized if needed. For example, `BasicAuth` generates the following for the credentials **root:pa55w0rd**:

```
Basic cm9vdDpwYTU1dzByZA==
```

In this case the **"Basic"** prefix before the encoded credentials is the authorization _type_. This can be customized as follows:

```Swift
let auth = BasicAuth(username: "root", password: "pa55w0rd")
auth.type = "BasicAuth"

let baseUrl = URL(string: "https://base.url/v1")!
let spider = Spider.web(withBaseUrl: baseUrl, auth: .basic(auth))

spider.get("/topSecretData") { (response) in
    print("Got a response!")
}
```

Likewise, the `TokenAuth` _"Bearer"_ type can be modified in the same way.

### Working with Responses

As mentioned above, `SpiderResponse` objects are clean & easy to work with. A typical data response might look something like this:

```Swift
Spider.web.get(path: "https://some/data/endpoint") { (response) in

    guard let data = response.data as? Data, response.err == nil else {

        var message = "There was an error fetching the data"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    print("Successfully fetched the data: \(data)")

}
```

A lot of the time the data we're interested in is `JSON` formatted. Spider makes this kind of data easy to work with.

```Swift
Spider.web.get(path: "https://some/json/endpoint") { (response) in

    guard let data = response.data as? Data, let json = data.json() as? [String: Any], response.err == nil else {

        var message = "There was an error fetching the json data"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    print("Successfully fetched the json data: \(json)")

}
```

Notice how we call `json()` on our response data. This helper function will attempt to serialize our data into a JSON object for us to work with. The function is defined as an extension on `Data`:

```Swift
public func json() -> Any?
```

If the data cannot be serialized, this function will return `nil`; causing our above `guard` statement to fail.

If the JSON response is formatted as an array (i.e. a list of users), don't forget to cast it as such!

```Swift
Spider.web.get(path: "https://list/of/users") { (response) in

    guard let data = response.data as? Data, let users = data.json() as? [[String: Any]], response.err == nil else {

        var message = "There was an error fetching the json data"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    for userDictionary in users {
        print("Fetched user: \(userDictionary["name"] as! String)")
    }

}
```

### Promises

Spider has built-in support for [PromiseKit](http://promisekit.org). Promises help keep your codebase clean & readable by eliminating pesky nested callbacks.

```Swift
Spider.web.get(path: "https://jsonplaceholder.typicode.com/photos").then { (response) -> Promise<SpiderResponse> in

    guard let data = response.data as? Data, let photos = data.json() as? [[String: Any]], response.err == nil && photos.count > 0 else {
        throw SpiderError.badResponse
    }

    return Spider.web.get(path: photos[0]["url"] as! String)

}.then { (response) -> Void in

    guard let data = response.data as? Data, let image = UIImage(data: data) else {
        throw SpiderError.badResponse
    }

    print(image)

}.catch { (error) in

    print(error)

}
```

This is just a basic example of how promises can help organize your code. For more information, please visit [PromiseKit](http://promisekit.org). I highly encourage you to consider using promises whenever possible.

## To-do
- Simple object mapping
- Request param serialization options (json (default), url query (http://hello.world?help=1&yolo=true))
- Data transfer (with progress reporting)
- Switch from AFNetworking to AlamoFire OR native NS* APIs
- Objective-C compatibility?
- Test coverage

## Contributing

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
