# iOS-game-Tutorial

This will be a beginner's tutorial for making games on the iphone. Not all concepts will be explained in detail, so if you have anything you don't understand, don't worry, it's normal.

So this is the story our game will have. We have an adventurer, who comes in contact with some alien insects and has to shoot them down or else she will die! This is what the main parts look like: 
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen1.png">
Let's start from the start, click on xcode app, currently the latest one available on the app score is xcode 10.2.1 so make sure that is the one you have. This should show up, click on create a new Xcode project

<p float="center">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen2.png" width="50%" height="50%">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen3.png" width="50%" height="50%">
  <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen4.png" width="50%" height="50%">
  <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen5.png" width="15%" height="15%">
</p>

Select game then fill in the game's name, we will creatively name it "codetechniqdemo", make sure the language is set at swift and don't worry about the other fields.
Before we change anything, run the app on the simulator by pressing the "play" button on top. (image 4) Is what we get, when you click on the screen it generates colorful spinning rectangles that quickly disappear. We won't use most of this because our game is different, so we have to reove some code, and replace it with our own. Let's get started.

As you can see in the first screenshot, we would like to have the app be only on landscape mode. So let's make sure it can't be used in portait mode by unchecking this box: 

 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen0.png">
 
First things first, let's make sure we download the art and sound for our game and have it ready in the Xcode project. Download the resources from [here](https://github.com/PhaelIshall/iOS-game-Tutorial/tree/master/game_art) (Go [here](https://github.com/PhaelIshall/iOS-game-Tutorial) and click on "download" then open the file "game_art".
Drag and drop the contents of the folder into your xcode project just so: 
![Screenshot 6](https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen6.png)
Make sure to select "copy items if necessary"
![Screenshot 7](https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen7.png)
Now that's done, let's remove the current game in the project. Open the file **GameScene.sks**, select the sprite that says "Hello World" and delete it.
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen10.png">

Next, go to gameScene.swift and just delete everything inside the class. This is what should remain: 

```
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
}
```

Now, let's get started! Open your **GameViewController.swift** file, this is what you should see: 
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen9.png">

This is a normal UIViewController (think of it like the code behind what you see on any given screen) with an SKView for a root view. This means that it contains a SpriteKit scene.
Let's start by adding our player to the screen. All our character will start as static characters without animation, we will add this as a bonus later on. 
Go to your **GameScene.swift** file and add the following:
```
let player = SKSpriteNode(imageNamed: "hero")
override func didMove(to view: SKView) {
  backgroundColor = SKColor.white
  player.position = CGPoint(x: frame.midX, y: size.height * frame.midX)
  addChild(player)
}
```


