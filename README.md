![Spider](Resources/logo.png)

[![Version](https://img.shields.io/cocoapods/v/Spider-Web.svg?style=for-the-badge)](http://cocoapods.org/pods/Spider-Web)
![Swift](https://img.shields.io/badge/Swift-5-orange.svg?style=for-the-badge)
![iOS](https://img.shields.io/badge/iOS-12+-green.svg?style=for-the-badge)
[![License](https://img.shields.io/cocoapods/l/Spider-Web.svg?style=for-the-badge)](http://cocoapods.org/pods/Spider-Web)

## Overview
Spider is an easy-to-use web framework built for speed & readability. Modern syntax & response handling makes working
with web services so simple - it's almost spooky.

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

Spider can be used in many different ways. Most times, the shared Spider instance is all you need.

```swift
Spider.web
  .get("https://path/to/endpoint")
  .data { response in
    print("We got a response!")
  }
```

This makes a **GET** request with a given path, then returns a `Response` object.

### Base URLs

Because we typically make more than one request to a given API, using _base URLs_ just makes sense. This is also useful when we need to switch between versions of API's (i.e. dev, pre-prod, prod, etc...).

```swift
let spider = Spider.web(baseUrl: "https://base.url/v1")

spider
  .get("/users")
  .data { response in
    print("We got a response!")
  }

spider
  .get("/locations")
  .data { response in
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

Spider.web
  .post("https://path/to/endpoint", parameters: params)
  .data { response in
    print("We got a response!")
  }
```

This will take your parameters and pass them along in the request's body. For **GET** requests, parameters will be encoded into the path as query parameters.

### Spider Instances

So far, we have been working with the shared instance of Spider. This is usually all you need. Just in case you need more control, Spider also supports a more typical instantiation flow.

```swift
let tarantula = Spider()

tarantula
  .get("https://path/to/endpoint")
  .data { response in
    print("Tarantula got a response!")
  }
```

Instead of using the shared Spider instance, we created our own instance named _tarantuala_ and made a request with it. Scary! Naturally, Spider instances created like this also support base URLs:

```swift
let blackWidow = Spider(baseUrl: "https://base.url/v1")

blackWidow
  .get("/users")
  .data { response in
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

Spider.web
  .perform(request)
  .data { response in
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

let request = MultipartRequest(
    method: .put,
    path: "https://path/to/upload",
    parameters: nil,
    files: [file]
)

Spider.web
  .perform(request)
  .data { response in
    print("We got a response!")
  }
```

`MultipartRequest` is a `Request` subclass that is initialized with an array of `MultipartFile` objects. Everything else works the exact same as a normal request.

### Authorization

Currently, Spider supports the following authorization types:
- Basic (user:pass base64 encoded)
- Bearer token

Authorization can be added on a per-request or instance-based basis. Typically we would want to provide our Spider instance authorization that all requests would be sent with:

```swift
let bigHairySpider = Spider.web(
    baseUrl: "https://base.url/v1",
    authorization: TokenRequestAuth(value: "0123456789")
)

bigHairySpider
  .get("/topSecretData")
  .data { response in
    print("Big hairy spider got a response!")
  }
```

However, authorization can also be provided on a per-request basis if it better fits your situation:

```swift
let token = TokenRequestAuth(value: "0123456789")
let mySpider = Spider.web(baseUrl: "https://base.url/v1")

mySpider
  .get("/topSecretData", authorization: token)
  .data { response in
    print("Spider got a response!")
  }
```

Advanced requests can also provide authorization:

```swift
let request = Request(
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

Spider.web
  .perform(request)
  .data { response in
    print("We got a response!")
  }
```

By default, authorization is added to the _"Authorization"_ header field. This can be changed by passing in a custom field when creating the authorization:

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

charlotte
  .get("/topSecretData")
  .data { response in
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

spider
  .get("/topSecretData")
  .data { response in
    print("Got a response!")
  }
```

Likewise, the `TokenRequestAuth` _"Bearer"_ prefix can be modified in the same way.

### Responses

`Response` objects are clean & easy to work with. A typical data response might look something like the following:

```swift
Spider.web
  .get("https://some/data/endpoint")
  .data { response in

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

`Response` also has helper `value` & `error` properties if you prefer that over the result syntax:

```swift
Spider.web
  .get("https://some/data/endpoint")
  .data { response in

    if let error = response.error {
        // Handle the error
        return
    }

    guard let data = response.value else {
        // Missing data
        return
    }

    // Do something with the response data!

  }
```

#### Workers & Serialization
When asked to perform a request, Spider creates & returns a `RequestWorker` instance. Workers are what actually manage the execution of requests, and serialization of responses. For instance, the above example could be broken down as follows:

```swift
let worker = Spider.web.get("https://some/data/endpoint")

worker.data { response in

    if let error = response.error {
        // Handle the error
        return
    }

    guard let data = response.value else {
        // Missing data
        return
    }

    // Do something with the response data!

}
```

If you'd rather work directly with response _values_ instead of responses themselves, each worker function has a raw value alternative:

```swift
let worker = Spider.web.get("https://some/data/endpoint")

worker.dataValue { (data, error) in

    if let error = error {
        // Handle the error
        return
    }

    guard let data = data else {
        // Missing data
        return
    }

    // Do something with the data!

}
```

In addition to `Data`, `RequestWorker` also supports the following serialization functions:

```swift
func string(encoding: String.Encoding, completion: ...)
func stringValue(encoding: String.Encoding, completion: ...)

func json(completion: ...)
func jsonValue(completion: ...)
func jsonArray(completion: ...)
func jsonArrayValue(completion: ...)

func image(completion:)
func imageValue(completion: ...)

func decode<T: Decodable>(type: T.Type, completion: ...)
func decodeValue<T: Decodable>(type: T.Type, completion: ...)
```

Custom serialization functions can be added via `RequestWorker` extensions.

### Images

Image downloading & caching is supported via `SpiderImageDownloader` & `SpiderImageCache`. Spider uses the excellent [Kingfisher](https://github.com/onevcat/Kingfisher) library to manage image downloading & caching behind-the-scenes.

##### SpiderImageDownloader

Downloading images with `SpiderImageDownloader` is easy!

```swift
SpiderImageDownloader.getImage("http://url.to/image.png") { (image, isFromCache, error) in

    guard let image = image,
        error == nil else {
        // Handle error
    }

    // Do something with the image!

}
```

The above `getImage()` function returns a discardable task that can be used to cancel the download if needed:

```swift
let task = SpiderImageDownloader.getImage("http://url.to/image.png") { (image, isCachedImage, error) in
    ...
}

task.cancel()
```

By default, `SpiderImageDownloader` does not cache downloaded images. If you want images to be cached, simply set the `cache` flag to `true` when calling the `getImage()` function.

##### SpiderImageCache

Caching, fetching, & removing images from the cache:

```swift
let imageCache = SpiderImageCache.shared
let image: UIImage = ...
let key = "my_image_key"

// Add an image to the cache
imageCache.cache(image, forKey: key) {
    // Finished caching image!
}

// Fetch an image from the cache
if let image = imageCache.image(forKey: key) {
    // Do something with the image!
}

// Remove an image from the cache
imageCache.removeImage(forKey: key) {
    // Finished removing image!
}
```

You can also clean the cache:

```swift
// Clean the disk cache
imageCache.clean(.disk)

// Clean the memory cache
imageCache.clean(.memory)

// Clean all caches
imageCache.cleanAll()
```

### UI Integrations

Spider also has some nifty UI integrations, like image view loading!

```swift
imageView.web.setImage("http://url.to/image.png")
```

Currently, Spider has integrations for the following UI components:
- `UIImageView` / `NSImageView`

### Promises

Spider has built-in support for [PromiseKit](http://promisekit.org). Promises help keep your codebase clean & readable by eliminating pesky nested callbacks.

```swift
Spider.web
  .get("https://jsonplaceholder.typicode.com/photos/1")
  .decodeValue(Photo.self)
  .then { photo -> Promise<Image> in

    return Spider.web.get(photo.url).imageValue()

  }.done { image in

    // Do something with the image!

  }.catch { error in

    // Handle error

  }

```

This is just a basic example of how promises can help organize your code. For more information, please visit [PromiseKit](http://promisekit.org).

#### Debug Mode

Enabling Spider's `isDebugEnabled` flag will print all debug information (including all outgoing requests) to the console.

## Contributing

Pull-requests are more than welcome. Bug fix? Feature? Open a PR and we'll get it merged in!
