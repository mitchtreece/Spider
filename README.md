![Spider](Resources/logo.png)

[![Version](https://img.shields.io/cocoapods/v/Spider-Web.svg?style=flat)](http://cocoapods.org/pods/Spider-Web)
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/Spider-Web.svg?style=flat)](http://cocoapods.org/pods/Spider-Web)
[![License](https://img.shields.io/cocoapods/l/Spider-Web.svg?style=flat)](http://cocoapods.org/pods/Spider-Web)

## Overview
Spider is an easy-to-use web framework built for speed & readability. Spider's modern syntax & response handling makes working with web services fun again.

## Installation
### CocoaPods
Spider is integrated with CocoaPods!

1. Add the following to your `Podfile`:
```
use_frameworks!
pod 'Spider-Web'
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
public typealias SpiderResponse = (req: SpiderRequest, res: URLResponse?, data: Any?, err: Error?)
```

It contains 4 objects. The `SpiderRequest` request (_req_), `URLResponse` object (_res_), response data (_data_), and an error object (_err_). Easy to use & understand, plus it helps keep our code readable! Hooray!

### Base URLs

Because we typically make more than one request to a given API, using _base URLs_ just makes sense. This is also useful when we need to switch between versions of API's (i.e. dev, pre-prod, prod, etc...).

```Swift
let spider = Spider.web(withBaseUrl: "https://base.url/v1")

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
let blackWidow = Spider(baseUrl: "https://base.url/v1")
blackWidow.get("/users") { (response) in
    print("Black Widow got a response!")
}
```

### Advanced Requests

Spider also supports advanced request options. You can configure and perform a `SpiderRequest` manually:

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
let token = TokenAuth(value: "0123456789")
let bigHairySpider = Spider.web(withBaseUrl: "https://base.url/v1", auth: token)
bigHairySpider.get("/topSecretData") { (response) in
    print("Big hairy spider got a response!")
}
```

However, authorization can also be provided on a per-request basis if it better fits your situation:

```Swift
let token = TokenAuth(value: "0123456789")
let aSpider = Spider.web(withBaseUrl: "https://base.url/v1")
aSpider.get("/topSecretData", auth: token) { (response) in
    print("Spider got a response!")
}
```

Advanced requests can also provide authorization:

```Swift
let token = TokenAuth(value: "0123456789")

let request = SpiderRequest(method: .get, path: "https://path/to/endpoint")
request.header.accept = [.image_jpeg, .custom("custom_accept_type")]
request.header.set(value: "12345", forHeaderField: "user_id")
request.auth = token

Spider.web.perform(request) { (response) in
    print("We got a response!")
}
```

By default, auth is added to the _"Authorization"_ header field of your request. This can be changed by passing in a custom field when creating the auth:

```Swift
let basic = BasicAuth(username: "root", password: "pa55w0rd", headerField: "Credentials")
let charlotte = Spider.web(withBaseUrl: "https://base.url/v1", auth: basic)
charlotte.get("/topSecretData") { (response) in
    print("Charlotte got a response!")
}
```

The authorization _type_ can also be customized if needed. For example, `BasicAuth` generates the following for the credentials **root:pa55w0rd**

```
Basic cm9vdDpwYTU1dzByZA==
```

In this case the **"Basic"** prefix before the encoded credentials is the authorization _type_. This can be customized as follows:

```Swift
let basic = BasicAuth(username: "root", password: "pa55w0rd")
basic.type = "Login"

let spider = Spider.web(withBaseUrl: "https://base.url/v1", auth: basic)
spider.get("/topSecretData") { (response) in
    print("Got a response!")
}
```

Likewise, the `TokenAuth` _"Bearer"_ type can be modified in the same way.

### Working with Responses

As mentioned above, `SpiderResponse` objects are clean & easy to work with. A typical data response might look something like this:

```Swift
Spider.web.get("https://some/data/endpoint") { (response) in

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
Spider.web.get("https://some/json/endpoint") { (response) in

    guard let data = response.data as? Data, let json = data.json, response.err == nil else {

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

Notice how we access `json` on our response data. This nifty little property is available because by default, Data conforms to the JSONConvertible protocol. Objects conforming to this protocol provide these properties:

```Swift
var json: JSON? { get }
var jsonArray: [JSON]? { get }
var jsonData: Data? { get }
```

`JSON` is a typealias defined as:

```Swift
typealias JSON = [String: Any]
```

By default `Dictionary`, `Array`, & `Data` all conform to `JSONConvertible`.

If the JSON response is formatted as an array (i.e. a list of users), don't forget to access the `jsonArray` property on our data instead of `json`.

```Swift
Spider.web.get("https://list/of/users") { (response) in

    guard let data = response.data as? Data, let users = data.jsonArray, response.err == nil else {

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

### Images

Image downloading & caching is supported via `SpiderImageDownloader` & `SpiderImageCache`. Spider uses the excellent [SDWebImage](https://github.com/rs/SDWebImage) library to manage image downloading & caching behind-the-scenes.

##### SpiderImageDownloader

Downloading images with `SpiderImageDownloader` is easy!

```Swift
SpiderImageDownloader.getImage("http://url.to/image.png") { (image, isCachedImage, error) in

    guard let image = image, error == nil else {
        // Handle error
    }

    // Do something with the image!

}
```

The above `getImage()` function returns a discardable token that can be used to cancel the image download if needed:

```Swift
let token = SpiderImageDownloader.getImage("http://url.to/image.png") { (image, isCachedImage, error) in
    ...
}

SpiderImageDownloader.cancel(for: token)
```

By default, `SpiderImageDownloader` does not cache downloaded images. If you want images to be cached, simply set the `cache` flag to `true` when calling the `getImage()` function.

##### SpiderImageCache

Caching, fetching, & removing images from the cache:

```Swift
let image: UIImage = ...
let key = "my_image_key"

// Add an image to the cache
SpiderImageCache.shared.cache(image, forKey: key)

// Fetch an image from the cache
if let image = SpiderImageCache.shared.image(forKey: key) {
    // Do something with the image!
}

// Remove an image from the cache
SpiderImageCache.shared.removeImage(forKey: key)
```

You can also clean the cache:

```Swift
// Clean the disk cache
SpiderImageCache.shared.clean(.disk)

// Clean the memory cache
SpiderImageCache.shared.clean(.memory)

// Clean all caches
SpiderImageCache.shared.cleanAll()
```

### UIKit Integration

Spider also has some nifty UIKit integrations, like `UIImageView` image downloading!

```Swift
imageView.web.setImage("http://url.to/image.png")
```

Currently, Spider has integrations for the following UIKit components:
- `UIImageView`

### Weavable

Spider has basic object mapping features via it's `Weavable` protocol. Objects wishing to conform to `Weavable` must implement the following failable initializer:

```Swift
init?(json: JSON)
```

A simple `User` object might look something like this:

```Swift
class User: Weavable {

    public var name: String?
    public var age: Int?

    required init?(json: JSON) {

        self.name = json["name"] as? String
        self.age = json["age"] as? Int

    }

}
```

```Swift
Spider.web.get("https://get/user/123") { (response) in

    guard let data = response.data as? Data, let userDict = data.json, response.err == nil else {

        var message = "There was an error fetching the json object"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    if let user = Weaver<User>(userDict).map() {
        print("Fetched user: \(user.name)")
    }

}
```

Array mapping:

```Swift
Spider.web.get("https://list/of/users") { (response) in

    guard let data = response.data as? Data, let userArray = data.jsonArray, response.err == nil else {

        var message = "There was an error fetching the json array"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    if let users = Weaver<User>(userArray).arrayMap() {
        print("Fetched \(users.count) users")
    }

}
```

### Promises

Spider has built-in support for [PromiseKit](http://promisekit.org). Promises help keep your codebase clean & readable by eliminating pesky nested callbacks.

```Swift
Spider.web.get("https://jsonplaceholder.typicode.com/photos").then { (response) -> Promise<SpiderResponse> in

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
- Upload & download tasks with progress
- Objective-C compatibility
- Test coverage
- Socket support

## Contributing

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
