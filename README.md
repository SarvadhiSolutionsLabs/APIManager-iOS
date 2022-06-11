# API Manager
- Using this framework, Write less code and managed structured data for API request. 
- We have created framework for API request. We can move framework into our project and use that framework.
- You can find below: How can we use this framework?

# Run Project
- To run demo project - open `APIManagerDemo.xcworkspace` in xcode.

# Use
Step 1
- Move `APIManager.xcodeproj` into your project.
- Click on your project and go to `General` Tab. (Ex. Click on APIManagerDemo)
- Click on `+` in Frameworks, Libraries and Embedded content.
- Select `APIManager.framework`.

Step 2
- import APIManager
- Create API Target.
```
let apiTarget = APITargetType.init(baseURL: URL(string: "YOUR_BASE_URL")!, path: "YOUR_API_ENDPOINT", method: [YOUR_API_METHOD], task: .requestPlain, headers: YOUR_API_HEADER)
```
- Use that API Target as request.
```
APIManager.request(apiTarget, success: { (JSON) in
    print(JSON)
}, error: { (errorStr) in
    debugPrint(errorStr)
}, failure: { (error) in
    debugPrint(error.localizedDescription)
})
```
