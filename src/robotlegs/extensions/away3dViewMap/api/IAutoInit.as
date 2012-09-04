// ------------------------------------------------------------------------------
// Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
// NOTICE: You are permitted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// ------------------------------------------------------------------------------

package robotlegs.extensions.away3dViewMap.api
{
	/**
	 * The IAutoInit interface which marks object eligible for automatic initialization and destruction
	 */	
	public interface IAutoInit
	{
		/**
		 * Object is placed on scene and can be initialized.
		 */		
		function init():void;
		
		/**
		 * Object is removed from scene and can be cleaned up.
		 */		
		function kill():void;
	}
}