// ------------------------------------------------------------------------------
// Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
// NOTICE: You are permitted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// ------------------------------------------------------------------------------

package robotlegs.extensions.away3dViewMap.api
{
	import flash.events.Event;
	
	public class Away3DViewMapEvent extends Event
	{
		
		public static const STARTUP_COMPLETE:String = "startupComplete";
		
		public function Away3DViewMapEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new Away3DViewMapEvent(type);
		}
		
		
	}
}