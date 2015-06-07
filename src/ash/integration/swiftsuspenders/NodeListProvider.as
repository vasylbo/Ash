package ash.integration.swiftsuspenders
{
	import ash.core.Engine;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.dependencyproviders.DependencyProvider;

	/**
	 * A custom dependency provider for SwiftSuspenders to allow injection
	 * of NodeList objects based on the node class they contain.
	 * 
	 * <p>This enables injections rules like</p>
	 *
	 * <p>[Inject(nodeType="MyNode")]
	 * public var nodes : NodeList;</p>
	 *
	 * Has to be provided by nodes package, to be capable find MyNode in it.
	 */
	public class NodeListProvider implements DependencyProvider
	{
		private var engine : Engine;
		private var nodesPackage : String;

		public function NodeListProvider( engine : Engine, nodesPackage : String )
		{
			this.engine = engine;
			this.nodesPackage = nodesPackage + ".";
		}

		public function apply( targetType : Class, activeInjector : Injector, injectParameters : Dictionary ) : Object
		{
			if ( injectParameters["nodeType"] )
			{
				var nodeDefinitionName : String = nodesPackage + injectParameters["nodeType"];
				var nodeClass : Class = getDefinitionByName( nodeDefinitionName ) as Class;
				if ( nodeClass )
				{
					return engine.getNodeList( nodeClass );
				}
			}
			return null;
		}

		public function destroy() : void
		{

		}
	}
}
