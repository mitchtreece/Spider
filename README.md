![Spider](Resources/logo.png)

[![Version](https://img.shields.io/cocoapods/v/Spider-Web.svg?style=for-the-badge)](http://cocoapods.org/pods/Spider-Web)
![Swift](https://img.shields.io/badge/Swift-5-orange.svg?style=for-the-badge)
![iOS](https://img.shields.io/badge/iOS-11--12-green.svg?style=for-the-badge)
[![License](https://img.shields.io/cocoapods/l/Spider-Web.svg?style=for-the-badge)](http://cocoapods.org/pods/Spider-Web)

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

The `SpiderResponse` object is a fancy object that encapsulates relevant properties of an HTTP response. It contains 4 properties: the `SpiderRequest` request (_req_), `URLResponse` object (_res_), response data (_data_), and an error object (_err_). Easy to use & understand, plus it helps keep our code readable! Hooray!

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

### Advanced & Multipart Requests

Spider also supports more fine-tuned request options. You can configure and perform a `SpiderRequest` manually:

```Swift
let request = SpiderRequest(method: "GET", path: "https://path/to/endpoint", parameters: nil)
request.header.accept = [.image_jpeg, .custom("custom_accept_type")]
request.header.set(value: "12345", forHeaderField: "user_id")

Spider.web.perform(request) { (response) in
    print("We got a response!")
}
```

Multipart data requests can also be constructed & executed in a similar fashion:

```Swift
let data = UIImagePNGRepresentation(image)!
let file = MultipartFile(data: data, key: "image", name: "image.png", type: .image_png)
let request = SpiderMultipartRequest(method: "PUT",
                                     path: "https://path/to/upload",
                                     parameters: nil,
                                     files: [file],
                                     auth: nil)

Spider.web.perform(request) { (response) in
    print("We got a response!")
}
```

`SpiderMultipartRequest` is a `SpiderRequest` subclass that is initialized with an array of `MultipartFile` objects. Everything else works the exact same as a normal (non-multipart) request.

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

let request = SpiderRequest(method: "GET", path: "https://path/to/endpoint")
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

    guard let data = response.data, response.err == nil else {

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

A lot of the time the data we're interested in is `JSON` formatted. Spider makes this kind of response easy to work with.

```Swift
Spider.web.get("https://some/json/endpoint") { (response) in

    guard let json = response.json(), response.err == nil else {

        var message = "There was an error fetching the json object"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    print("Successfully fetched the json object: \(json)")

}
```

Notice how we call `json()` on our response. This nifty little function attempts to serialize our response data into a `JSON` object. Likewise, `jsonArray()` will attempt to serialize our response data into an array of `JSON` objects.

```Swift
Spider.web.get("https://list/of/users") { (response) in

    guard let users = response.jsonArray(), response.err == nil else {

        var message = "There was an error fetching the json object"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    for dict in users {
        print("Fetched user: \(dict["name"] as! String)")
    }

}
```

### Serializers

Response serialization is handled on the `SpiderResponse` object. The functions `json()` & `jsonArray()` are provided via an extension on `SpiderResponse`. Likewise, to implement custom response serialization, simply extend the `SpiderResponse` object as needed. For example, `UIImage` response serialization might look something like this:

```Swift
extension SpiderResponse {

    func image() -> UIImage? {

        guard let data = self.data else { return nil }

        if let image = UIImage(data: data) {
            return image
        }

        return nil

    }

}
```

With that implemented, working with an image serialized response would work as follows:

```Swift
Spider.web.get("https://path/to/image.png") { (response) in

    guard let image = response.image(), response.err == nil else {

        var message = "There was an error fetching the image"
        if let error = response.err {
            message = error
        }

        print(message)
        return

    }

    print("Fetched image: \(image)")

}
```

Spider has built-in support for the following object serialization types:

- `String`
- `JSON` & [`JSON`]
- `UIImage`

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
