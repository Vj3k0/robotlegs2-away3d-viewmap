// ------------------------------------------------------------------------------
// Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
// NOTICE: You are permitted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// ------------------------------------------------------------------------------

package robotlegs.extensions.away3dViewMap.impl
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.events.Scene3DEvent;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.extensions.away3dViewMap.api.Away3DViewMapEvent;
	import robotlegs.extensions.away3dViewMap.api.IAutoInit;
	import robotlegs.extensions.away3dViewMap.api.IAway3DViewMap;

	/**
	 * 
	 * Away3DViewMap Impl
	 * 
	 * @author jamieowen
	 */
	public class Away3DViewMap implements IAway3DViewMap
	{
		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/
		
		[Inject]
		public var view3D:View3D;
		
		[Inject]
		public var mediatorMap : IMediatorMap;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/
		
		
		/*============================================================================*/
		/* Constructor
		/*============================================================================*/
		
		public function Away3DViewMap()
		{
			
		}

		[PostConstruct]
		public function init() : void
		{
			// listen for ObjectContainer3D events
			view3D.scene.addEventListener( Scene3DEvent.ADDED_TO_SCENE, onSceneAdded );
			view3D.scene.addEventListener( Scene3DEvent.REMOVED_FROM_SCENE, onSceneRemoved );

			// add scene as view to allow a Away3D Scene Mediator
			// Note : we don't support swapping scenes now - one scene will do.
				
			addAway3DView( view3D.scene );
			
			// dispatch event to signalize that 3D scene is setup and ready to be used
			// i.e. add handler for this event to know when it is safe to access view, scene, etc. 
			
			eventDispatcher.dispatchEvent(new Away3DViewMapEvent(Away3DViewMapEvent.STARTUP_COMPLETE));
		}

		/*============================================================================*/
		/* Public Methods
		/*============================================================================*/
		
		public function addAway3DView(view : *) : void
		{
			if( validateView(view))
			{
				mediatorMap.mediate(view);
				
				if (view is IAutoInit)
					IAutoInit(view).init();
			}
			else
				throw new Error("Not sure what to do with this view type..");
		}

		public function removeAway3DView(view : *) : void
		{
			mediatorMap.unmediate(view);
			
			if (view is IAutoInit)
				IAutoInit(view).kill();
		}

		/*============================================================================*/
		/* Private Methods
		/*============================================================================*/
		
		/** We want to mediate ObjectContainer3D and Scene3D, and Scene3D doesn't extend ObjectContainer3D - this method will validate a view type for now **/
		private function validateView(view:*):Boolean
		{
			if( view is Scene3D || view is ObjectContainer3D ){
				return true;
			}else
				return false;
		}
		
		private function onSceneAdded(event : Scene3DEvent) : void
		{
			addAway3DView(event.objectContainer3D);
		}

		private function onSceneRemoved(event : Scene3DEvent) : void
		{
			removeAway3DView(event.objectContainer3D);
		}
	}
}
