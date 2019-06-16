# iOS-game-Tutorial

This will be a beginner's tutorial for making games on the iphone. Not all concepts will be explained in detail, so if you have anything you don't understand, don't worry, it's normal.

So this is the story our game will have. We have an adventurer, who comes in contact with some alien insects and has to shoot them down or else she will die! This is what the main parts look like: 
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen1.png">

## First steps: Setting up 
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
Drag and drop the contents of the three folders in the screenshot into your xcode project just so: 
![Screenshot 6](https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen6.png)
Make sure to select "copy items if necessary"
![Screenshot 7](https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen7.png)

Open the file **Assets.xcassets** Open. Drag the file "Hero.png" into Assets like so: 

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen11.png">

Now that's done, let's remove the current game in the project. Open the file **GameScene.sks**, select the sprite that says "Hello World" and delete it.
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen10.png">

## Next Step: Coding!  
Next, go to gameScene.swift and just delete everything inside the class. This is what should remain: 

```
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
}
```


### Add the hero
Now, let's get started! Open your **GameViewController.swift** file, this is what you should see: 
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen9.png">

This is a normal UIViewController (think of it like the code behind what you see on any given screen) with an SKView for a root view. This means that it contains a SpriteKit scene.
Let's start by adding our player to the screen. All our character will start as static characters without animation, we will add this as a bonus later on. 
Go to your **GameScene.swift** file and add the following:
```
let hero = SKSpriteNode(imageNamed: "hero") //Create Sprite for hero 
override func didMove(to view: SKView) {
    backgroundColor = SKColor.white
    hero.position = CGPoint(x: frame.midX, y: frame.midY) //position in the middle of the screen
    hero.setScale(1.25) //Enlarge by 1.25, you can remove this or change the value depending on the size you like
    addChild(hero)  //to make the sprite appear on the screen, add as a child of the screen 
}
```
Now run the app, you should see this
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen12.png">

### Add the monsters

Now, we want to add some enormous alien Bugs that our hero has to kill to defend herself. We want them to come from one end of the screen towards our hero. 

First, let's ove the hero to the left side of the screen, so she can only be attacked from one side. To do this, replace this line in **GameScene.swift**
```
hero.position = CGPoint(x: frame.midX, y: frame.midY) //position in the middle of the screen
```
*with* 
```
hero.position = CGPoint(x: frame.minX + hero.size.width, y: frame.midY) //position in the middle of the screen
```
Now, those monsters. It won't be enough to just add them to the screen like we did for the hero, we also need to make them move from one side of the screen to the hero, and that movements in Swift language means adding an action.
Let's create a function that generates these bugs: 
```
func addBug(){
    let bug = SKSpriteNode(imageNamed: "bug") // create a bug sprite 
    let startingY = frame.midY
    bug.position = CGPoint(x: size.width + bug.size.width/2, y:  startingY)
    addChild(bug)
}
```
This should look familiar, since it is exactly what we did for the player. For now, all the monsters will start from the same point. While the x is set to slightly outside of the screen (*size.width + bug.size.width/2*) and y is the middle of the screen. This is still missing the movement. Add this bellow the previous code: 
```
let duration = random(min: CGFloat(2.0), max: CGFloat(4.0))
let moveAction = SKAction.move(to: CGPoint(x: -bug.size.width/2, y:  startingY), duration: TimeInterval(duration))
let finishAction = SKAction.removeFromParent()
bug.run(SKAction.sequence([moveAction, finishAction]))
 ```
So what are we doing here? To create the action, we're setting the duration to 2 seconds and the source position this sprite spawns from. After the action is comeplete, we remove it from the scene. Then, we run the action sequence, move, then disappear, this is so we can remove it from the scene when it is no longer visible. If we don't do this, we could end up having dozens of monsters consuming the memory of your iPhone and you can't even see them. This is what the full code looks like: 
```
func addBug() {
    let bug = SKSpriteNode(imageNamed: "bug")
    let startingY = random(min: -monster.size.height, max: size.height - monster.size.height)
    bug.position = CGPoint(x: size.width + bug.size.width/2, y:  startingY)
    bug.setScale(3)
    addChild(bug)
    let duration =  random(min: CGFloat(2.0), max: CGFloat(4.0))
    let moveAction = SKAction.move(to: CGPoint(x: frame.minX, y: frame.midY), duration: TimeInterval(duration))
    let finishAction = SKAction.removeFromParent()
    bug.run(SKAction.sequence([moveAction, finishAction]))
}
```
This is not enough, we need to call the function so that we can see the bugs on the screen. Since we want to generate several instances of bugs, we will add this action at the end of **didMove(to:)**. It repeats the call to the previous function, then it waits for 1 seconds, then repeats the same sequence.
```
let actionSequence = SKAction.sequence([SKAction.run(addBug),SKAction.wait(forDuration: 1.0)])
run(SKAction.repeatForever(actionSequence))
```
Now, build and run the project. What do you see? 
Well, this looks very underwhelming. This is because we did not randomize the the positions the bugs come from. It makes a big difference! This is the code that implements **random()** functions: 
```
 func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float.random(in: Float(min) ..< Float(max)))
 }
    
func addBug() {
    let bug = SKSpriteNode(imageNamed: "bug")
    let startingY = random(min: -size.height/2 - bug.size.height, max: size.height/2 + bug.size.height)
    bug.position = CGPoint(x: size.width + bug.size.width/2, y: startingY)
    bug.setScale(3)
    addChild(bug)
    let duration = random(min: CGFloat(2.0), max: CGFloat(4.0))
    let moveAction = SKAction.move(to: CGPoint(x: frame.minX, y: frame.midY), duration: TimeInterval(duration))
    let finishAction = SKAction.removeFromParent()
    bug.run(SKAction.sequence([moveAction, finishAction]))
}
```
### Shooting thr bugs

There are many ways we can implement shooting the bugs. The way I chose to to click on the bug to send an arrow from the hero towards it. 

We need to override a predefined function called **touchesEnded**, see below 
```
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
   //Add code here 
}
```
Okay, now we need to add some code to the function above 
First, we need to check if the screen has been touched, and if that is the case, we need to detect the location of the touch
```
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
   guard let touch = touches.first else {
       return
   }
   let touchLocation = touch.location(in: self)
}
```

Next, we need to set up the original location of the projectile, you're probably used to this by now: create a sprite and set the location.
```
  let projectile = SKSpriteNode(imageNamed: "projectile")
  projectile.position = hero.position
```
We need to check if the touch on the screen is valid. For instance, we don't want to our hero shoot behind herself. To do this, we need to calculate the offset of the location to the projectile.
Ideally, we would like it to be as simple as this:
```
let offset = touchLocation - projectile.position
if offset.x < 0 { return }
```
However, there is no predefined operation '-' for CGPoint, we resolve this by using our helper file that implements the below function
```
func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
```
But let's not forget, we don't only want to show the projectile, we want to have an action that moves it across the screen towards the target. That means, we need to determine the direction of where to shoot. I hope you remember your highschool math, because this is what we will do
1. Get the vector between the hero and the touch location
2. Normalize the vector to have a unit vector that defines the desired direction
3. Multiply that unit vector by a large number to get a far away point that goes beyond the screen
Luckily we have our helper file to assist us in this endeavor, so we will just call the function that calculates the point for us. Make sure you understand the math behind it though!
The steps described above are implemented under **findProjectileDestination**, you can see the details in the helper file.
```
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
        return
    }
    let touchLocation = touch.location(in: self)
    let projectile = SKSpriteNode(imageNamed: "laser")
    projectile.setScale(3)
    projectile.position = hero.position
    if let destinationPoint = CGPoint.findProjectileDestination(touchPoint: touchLocation, heroLocation: projectile.position){
        addChild(projectile)
        let actionMove = SKAction.move(to: destinationPoint, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }else{
        return
    }
}
```
