# Away3D ViewMap

A Robotlegs2 extension to enable mapping IMediator's to Away3d ObjectContainer3D's.

## TODO

- Add example project and link it in doc
- Comment out code
- Test extension

## Features

Here are list of features that this extension introduces.

### Mediation
This an absolute bare minimum approach to mapping Away3D `ObjectContainer3D`/`Scene3D` to the RL2 Mediator Map.

It adds a configHandler to the context to handle a single `View3D` instance.

When a `View3D` instance is added, the `View3D` scene is listened to for `Scene3DEvent.ADDED_TO_SCENE` and `Scene3DEvent.REMOVED_FROM_SCENE` events.

When a `ObjectContainer3D` is added or removed it calls `MediatorMap.mediate()` 
or `MediatorMap.unmediate()` respectively.

***Note**: There is no eventMap, addViewListener(), addContextListener() yet.*

### Automatic initialization/disposing

For ease of use, if object wants to use automatic initialization/destruction it needs to implement `IAutoInit` interface. What it will do is, it will call `init` function when object is placed on scene and call `kill` when it is removed.

	public class SampleView extends ObjectContainer3D implements IAutoInit
	{
		public function SampleView() {
			super();
		}
		
		public function init():void {
			// Do some initialization...
		}
		
		public function kill():void {
			// Do some disposing...
		}
	}

### Away3D startup complete

Since Robotlegs framework doesn't have any specific event to mark that extension is finished setting up, event `Away3DViewMapEvent.STARTUP_COMPLETE` will be dispatched. At the time that this event is dispatched, it is safe to access any Away3D element (i.e. view, scene, etc.). 

You can use it to setup your 3D scene. In example, map it in your configuration to command:

	commandMap
		.map(Away3DViewMapEvent.STARTUP_COMPLETE)
		.toCommand(Setup3DSceneCommand);

Setup your scene in that command:

	public class Setup3DSceneCommand extends Command
	{
		[Inject]
		public var view:View3D;
		
		override public function execute():void {
			view.scene.addChild(new SampleView());
		}
	}

## Libraries
Libraries required for this extension are:

- Robotlegs v2.0.0b1
- Away3D v4.0.9_gold

## Credits
Original author of extension is [Jamie Owen](https://github.com/jamieowen) .





