![Spider](Resources/logo.png)

[![Version](https://img.shields.io/cocoapods/v/Spider-Web.svg?style=flat)](http://cocoapods.org/pods/Spider-Web)
![Swift](https://img.shields.io/badge/Swift-5-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/Spider-Web.svg?style=flat)](http://cocoapods.org/pods/Spider-Web)
![iOS](https://img.shields.io/badge/iOS-10,%2011-blue.svg)
[![License](https://img.shields.io/cocoapods/l/Spider-Web.svg?style=flat)](http://cocoapods.org/pods/Spider-Web)

## Overview
Spider is an easy-to-use web framework built for speed & readability. Modern syntax & response handling makes working
with web services so simple, it's almost spooky.

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

Spider can be used in many different ways. Most times, a shared (one-off) approach is all you need.

```swift
Spider.web.get("https://path/to/endpoint").data { response in
    print("We got a response!")
}
```

This makes a **GET** request with a given path, then returns a `Response` object.

### Base URLs

Because we typically make more than one request to a given API, using _base URLs_ just makes sense. This is also useful when we need to switch between versions of API's (i.e. dev, pre-prod, prod, etc...).

```swift
let spider = Spider.web(baseUrl: "https://base.url/v1")

spider.get("/users").data { response in
    print("We got a response!")
}

spider.get("/locations").data { response in
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

All variations of `Request` instantiation have a means for you to pass in request parameters. For example:

```swift
let params = ["user_id": "123456789"]

Spider.web.post("https://path/to/endpoint", parameters: params).data { response in
    print("We got a response!")
}
```

This will take your parameters and pass them along in the request's body. For **GET** requests, parameters will be encoded into the path as query parameters.

### Spider Instances

So far, we have been working with the shared instance of Spider. This is usually all you need. Just in case you need more control, Spider also supports a more typical instantiation flow.

```swift
let tarantula = Spider()

tarantula.get("https://path/to/endpoint").data { response in
    print("Tarantula got a response!")
}
```

Instead of using the shared Spider instance, we created our own instance named _tarantuala_ and made a request with it. Spooky! Naturally, Spider instances created like this also support base urls:

```swift
let blackWidow = Spider(baseUrl: "https://base.url/v1")

blackWidow.get("/users").data { response in
    print("Black Widow got a response!")
}
```

### Advanced & Multipart Requests

Spider also supports more fine-tuned request options. You can configure and perform a `Request` manually:

```swift
let request = Request(
    method: .get,
    path: "https://path/to/endpoint",
    parameters: nil
)

request.header.accept = [
    .image_jpeg,
    .custom("custom_accept_type")
]

request.header.set(
    value: "12345",
    forHeaderField: "user_id"
)

Spider.web.perform(request).data { response in
    print("We got a response!")
}
```

Multipart requests can also be constructed & executed in a similar fashion:

```swift
let file = MultipartFile(
    data: image.pngData()!,
    key: "image",
    name: "image.png",
    type: .image_png
)

let request = SpiderMultipartRequest(
    method: .put,
    path: "https://path/to/upload",
    parameters: nil,
    files: [file]
)

Spider.web.perform(request).data { response in
    print("We got a response!")
}
```

`MultipartRequest` is a `Request` subclass that is initialized with an array of `MultipartFile` objects. Everything else works the exact same as a normal request.

### Authorization

Currently, Spider supports the following authorization types:
- Basic (user:pass base64 encoded)
- Token

Authorization can be added on a per-request or instance-based basis. Typically we would want to provide our Spider instance authorization that all requests would be sent with:

```swift
let bigHairySpider = Spider.web(
    baseUrl: "https://base.url/v1",
    authorization: TokenRequestAuth(value: "0123456789")
)

bigHairySpider.get("/topSecretData").data { response in
    print("Big hairy spider got a response!")
}
```

However, authorization can also be provided on a per-request basis if it better fits your situation:

```swift
let token = TokenRequestAuth(value: "0123456789")
let mySpider = Spider.web(baseUrl: "https://base.url/v1")

mySpider.get("/topSecretData", authorization: token).data { response in
    print("Spider got a response!")
}
```

Advanced requests can also provide authorization:

```swift
let request = SpiderRequest(
    method: .get,
    path: "https://path/to/endpoint",
    authorization: TokenAuth(value: "0123456789")
)

request.header.accept = [
    .image_jpeg,
    .custom("custom_accept_type")
]

request.header.set(
    value: "12345",
    forHeaderField: "user_id"
)

Spider.web.perform(request).data { response in
    print("We got a response!")
}
```

By default, authorization is added to the _"Authorization"_ header field of your request. This can be changed by passing in a custom field when creating the auth:

```swift
let basic = BasicRequestAuth(
    username: "root",
    password: "pa55w0rd",
    field: "Credentials"
)

let charlotte = Spider.web(
    baseUrl: "https://base.url/v1",
    authorization: basic
)

charlotte.get("/topSecretData").data { response in
    print("Charlotte got a response!")
}
```

The authorization _prefix_ can also be customized if needed. For example, `BasicRequestAuth` generates the following for the credentials "root:pa55w0rd"

```
Basic cm9vdDpwYTU1dzByZA==
```

In this case, the _"Basic"_ prefix before the encoded credentials is the authorization _type_. This can be customized as follows:

```swift
let basic = BasicRequestAuth(
    username: "root",
    password: "pa55w0rd"
)

basic.prefix = "Login"

let spider = Spider.web(
    baseUrl: "https://base.url/v1",
    authorization: basic
)

spider.get("/topSecretData").data { response in
    print("Got a response!")
}
```

Likewise, the `TokenRequestAuth` _"Bearer"_ prefix can be modified in the same way.

### Responses

`Response` objects are clean & easy to work with. A typical data response might look something like this:

```swift
Spider.web.get("https://some/data/endpoint").data { response in

    switch response.result {
    case .success(let data):

        // Handle response data!
        break

    case .failure(let error):

        // Handle response error :(
        break

    }

}
```

`Response` also has helper `value` & `error` properties if you prefer that over the result syntax.

#### Workers & Serialization

TODO

### Images

Image downloading & caching is supported via `SpiderImageDownloader` & `SpiderImageCache`. Spider uses the excellent [Kingfisher](https://github.com/onevcat/Kingfisher) library to manage image downloading & caching behind-the-scenes.

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

### Weaver

Spider has basic object mapping features via it's `Weaver` class. Objects wishing to integrate with Spider's mapping features simply need to conform to Swift 4's built-in `Codable` protocol:

```Swift
struct User: Codable {

    var name: String
    var age: Int

}
```

```Swift
Spider.web.get("https://get/user/123") { (response) in

    guard let userDict = response.json(), response.err == nil else {

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

    guard let userArray = response.jsonArray(), response.err == nil else {

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

    guard let photos = response.jsonArray(), response.err == nil && photos.count > 0 else {
        throw SpiderError.badResponse
    }

    return Spider.web.get(path: photos[0]["url"] as! String)

}.then { (response) -> Void in

    guard let image = response.image() else {
        throw SpiderError.badResponse
    }

    print(image)

}.catch { (error) in

    print(error)

}
```

This is just a basic example of how promises can help organize your code. For more information, please visit [PromiseKit](http://promisekit.org). I highly encourage you to consider using promises whenever possible.

### Helpers

Some useful additions are also included to help cut down on development & debugging time.

#### Debug Mode

Enabling Spider's `isDebugModeEnabled` flag will print all debug information (including all outgoing requests) to the console.

#### cURL Generation

`SpiderRequest` includes a `printCURL()` function that, as the name implies, prints the cURL command for a given request.

```Swift
let request = SpiderRequest(method: "GET", path: "https://path/to/endpoint", parameters: ["user_id": "1234"])
request.header.set(value: "bar", forField: "foo")
request.printCURL()

==>

curl https://path/to/endpoint \
-X GET \
-H "foo: bar" \
-d "user_id=1234"
```

**NOTE**: If your request is dependent on a `Spider` instance's `baseUrl` _or_ `authorization` properties,
cURL information **will not** be accurate until _after_ the request is performed.

## To-do
- Better error handling for Weaver object mapping
- Objective-C compatibility
- Test coverage

## Contributing

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
