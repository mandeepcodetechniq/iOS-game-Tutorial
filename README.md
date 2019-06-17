# iOS-game-Tutorial

This will be a beginner's tutorial for making games on the iphone. Not all concepts will be explained in detail, so if you have anything you don't understand, don't worry, it's normal.

So this is the story our game will have. We have an adventurer, who comes in contact with some alien insects and has to shoot them down or else she will die! This is what the main parts look like: 
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/newScreen1.png">

## First steps: Setting up 
Let's start from the start, click on xcode app, currently the latest one available on the app score is xcode 10.2.1 so make sure that is the one you have. This should show up, click on create a new Xcode project

<p float="center">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen2.png" width="45%" height="45%">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen3.png" width="45%" height="45%">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/screen4.png" width="45%" height="45%">
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

## Set background

The folder you downloaded comes with three sets of backgrounds. Choose the ones you like and drag the contents of the folder into the **Assets.xcassets**. This is the backgroudn image I chose:

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/Battleground2.png">

Now, lets get started. Open **GameScene.sks** and go to the icon circled below, this is what you click on to add a sprite.

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/bar.png">

Write in the search bar "Sprite" and drag **Color Sprite** onto ths screen boudaries. Go to the **Attributes inspector**, then texture and change it to **sky** (or whatever layer should be at the very back of your Scene). Also change **zPosition = -6**. **zPosition** determines which layers go on top of each other, the lower the number, the more in the back the picture is.

<p float="center">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/texture.png" width="45% height="45%">
 <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/scene.png" width="45% height="45%">
</p>

Also, you'll notice that the orientation of the Scene is not landscape like we want. Go ahead and select **Scene** node and change the parameters as shown above.
The result looks just like 

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/sceneResult.png">

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

### Add the Alien Bugs

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
    bug.xScale = abs(bug.xScale) * -1 //To flip the bug vertically because the original images is pointing to the left 
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
So what are we doing here? To create the action, we're setting the duration to 2 seconds and the source position this sprite spawns from. After the action is comeplete, we remove it from the scene. Then, we run the action sequence, move, then disappear, this is so we can remove it from the scene when it is no longer visible. If we don't do this, we could end up having dozens of bugs consuming the memory of your iPhone and you can't even see them. This is what the full code looks like: 
```
func addBug() {
    let bug = SKSpriteNode(imageNamed: "bug")
    let startingY = random(min: -bug.size.height, max: size.height - bug.size.height)
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
Well, this looks very underwhelming.

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/result1.png">

This is because we did not randomize the the positions the bugs come from. It makes a big difference! This is the code that implements **random()** functions: 
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

The randomised generation of the bugs looks like this:

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/result2.png">

### Shooting the bugs

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
let laserBall = SKSpriteNode(imageNamed: "laser")
laserBall.position = hero.position
```
We need to check if the touch on the screen is valid. For instance, we don't want to our hero shoot behind herself. To do this, we need to calculate the offset of the location to the laserBall.
Ideally, we would like it to be as simple as this:
```
let offset = touchLocation - laserBall.position
if offset.x < 0 { return }
```
However, there is no predefined operation '-' for CGPoint, we resolve this by using our helper file that implements the below function
```
func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
```
But let's not forget, we don't only want to show the laserBall, we want to have an action that moves it across the screen towards the target. That means, we need to determine the direction of where to shoot. I hope you remember your highschool math, because this is what we will do
1. Get the vector between the hero and the touch location
2. Normalize the vector to have a unit vector that defines the desired direction
3. Multiply that unit vector by a large number to get a far away point that goes beyond the screen
Luckily we have our helper file to assist us in this endeavor, so we will just call the function that calculates the point for us. Make sure you understand the math behind it though!

Here's an image to explain the math a bit

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/math.png">

The steps described above are implemented under **findlaserBallDestination**, you can see the details in the helper file.
```
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
        return
    }
    let touchLocation = touch.location(in: self)
    let laserBall = SKSpriteNode(imageNamed: "laser")
    laserBall.setScale(3)
    laserBall.position = hero.position
    if let destinationPoint = CGPoint.findlaserBallDestination(touchPoint: touchLocation, heroLocation: laserBall.position){
        addChild(laserBall)
        let actionMove = SKAction.move(to: destinationPoint, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        laserBall.run(SKAction.sequence([actionMove, actionMoveDone]))
    }else{
        return
    }
}
```

This is the result, the laser balls go right though the bug monsters. We don't want that! Now we need to use Physics to detect collisions.

<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/firstBall.png">

### Physics, finally! 
SpriteKit comes with a built in Physics Engine, this means we can detect collision. Why do we want that? When a bug collides with the player, it's game over. When the laser ball collides with the bug, the bug dies. We want to implement that. 

Okay, here we are setting Physics categories. What are those? 
<img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/expl.png">

1. Each scene has a **physics world** behind it that controls certain aspects of the game, like gravity. This physics world is a simulation space for running physics calculations, it can tell us if two objects collide, how an object should be affected by gravity etc.

2,3. Each sprite will have a **physics body** that constitutes the boundaries of where we will start counting collisions. You can see in the photo above, we assign a *ball* physics body to the laser ball and a *rectangle* to the bug. As you can tell, it doesn't have to be very accurate, just needs to get the job done, so an approximation is good enough.

4,5. Like each type of  sprite has a physics body, each type of sprite also has a category. Let's name two categories, **bug** category and **laserBall** category. Now when two physics bodies collide (laser ball hits a bug), we can tell their categories and deal with them accordingly (remove both from screen for instance).
    - First, let's add this stuct to the top of **GameScene.swift**
      This is just the way to define categories in SpriteKit, using 32-bit integer acting as a bitmask. 
```
struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let bug       : UInt32 = 0b1       // 1 Binary for 1 
    static let laserBall: UInt32 = 0b10      // 10 Binary for 2
}
```

6. Now that we know the basics, this is how we deal with collisions. We have a physics world, we set a **contact delegate** on it that will be notified when two bodies collide, like explained above, we'll get their categories and then make them disppear.

### Coding the physics behind it all

go to **didMove(to:)** function and add the following code:

```
physicsWorld.gravity =.zero //No gravity in our physics world
physicsWorld.contactDelegate = self //the game scene is set as the delegate
```

inside **addBug()**, add these lines after creating the bug sprite:

```
bug.physicsBody = SKPhysicsBody(rectangleOf: bug.size) // create physics body, a rectangle like the picture shows
bug.physicsBody?.isDynamic = true // *dynamic* sprite means move actions will control the movement of the bug (declared in touchesEnded(..) and not by the physics engine. If we set this as false, our code won't detect teh collisions, report it and make the sprites disappear anymore
bug.physicsBody?.categoryBitMask = PhysicsCategory.bug // set category
bug.physicsBody?.contactTestBitMask = PhysicsCategory.laserBall // collision with which category should trigger a response (by notifying the contact delegate)
bug.physicsBody?.collisionBitMask = PhysicsCategory.none // which category of object should the bug category have teh physics engine handle contact with, like bouncing off. We don't want the balls bouncing off the bugs so we set it to none.
```

Now the same code is added after setting the laserBall position,
```
laserBall.physicsBody = SKPhysicsBody(circleOfRadius: laserBall.size.width/2)
laserBall.physicsBody?.isDynamic = true
laserBall.physicsBody?.categoryBitMask = PhysicsCategory.laserBall
laserBall.physicsBody?.contactTestBitMask = PhysicsCategory.bug
laserBall.physicsBody?.collisionBitMask = PhysicsCategory.none
laserBall.physicsBody?.usesPreciseCollisionDetection = true //This is important to set for fast moving bodies like laserBalls, because otherwise there is a chance that two fast moving bodies can pass through each other without a collision being detected.
```

We will also add this function to the end of **GameScene.swift** before the end of the class. 
```
func laserBallDidCollideWithBug(laserBall: SKSpriteNode, bug: SKSpriteNode) {
  laserBall.removeFromParent()
  bug.removeFromParent()
}
```

Next, we declare our **contact delegate**. You can find it ready in the end of our helper file. To understand delegates better, you should read up about them in the apple docs as they are essential for game and app development in swift. 

The method **didBegin(..)** declared in the extension will be called whenever two physics bodies collide where their **contactTestBitMask** variable is declared as each other. What does the method do? Well, two main things.

1. It sorts the two colliding bodies into firstBody and secondBody based on the category. Since laserBall category is always less than bug category (1<2 always true), it always sets the firstBody to be the laserBall and the secondBody to be the bug.

2. If the colliding bodies are indeed a bug and a laserBall, call **laserBallDidCollideWithBug(..)**

## Final touches 
### Adding sounds
add this code to the end of **didMove(to:)**

```
let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
backgroundMusic.autoplayLooped = true
addChild(backgroundMusic)
```
We also would like there to be some laser sound effects when we shoot a laserBall, let's all this after the guard statement in **touchesEnded(..)** 
```
run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
```
### Adding score and Game Over conditions
It's time to take a look at our last helper file **GameOverScene.swift**

Now, to use this file, we go to **GameScene.swift** and instead of only running the action sequence 
`bug.run(SKAction.sequence([actionMove, actionMoveDone]))`, we replace this line by some code that creates a new "lose action" that displays the game over scene when a bug goes off-screen:

```
let loseAction = SKAction.run() { [weak self] in
        guard let `self` = self else { return }
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size, won: false)
        self.view?.presentScene(gameOverScene, transition: reveal)
    }
bug.run(SKAction.sequence([moveAction, loseAction, finishAction]))
```

We should also add a counter to keep track of the number of bugs that we are destrying, we do this by adding a variable at the top of **GameScene** class `var bugsDestroyed = 0` then incrementing it with every successful collision by adding the below code to **laserBallDidCollideWithBug(laserBall : bug:)**
```
bugsDestroyed += 1
if bugsDestroyed > 30 {
  let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
  let gameOverScene = GameOverScene(size: self.size, won: true)
  view?.presentScene(gameOverScene, transition: reveal)
}
```
## Does it get better? 

Of course it does. Here are some things we can improve and add: 

1. Our hero, laserBall and bugs are not animated and can do better
2. We can show the current score during the game
3. We can save the best score and compare against it with every game
4. Make it more difficult

## Let's animate: 

### Animate hero: 

Well, this is pretty easy but it introduces a new concept called **Atlas**, this represents a group of images, each one is a frame of an animation. Together in gif format, they look like this: 
<p>
    <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/hero.gif">
    <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/bug.gif">
    <img src="https://github.com/PhaelIshall/iOS-game-Tutorial/blob/master/images/BallGIF.gif">
</p>
