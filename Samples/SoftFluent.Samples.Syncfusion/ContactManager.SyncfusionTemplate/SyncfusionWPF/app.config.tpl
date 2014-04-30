[%@ template inherits="CodeFluent.Producers.UI.BaseTemplate" %]
[%@ namespace name="System" %]
[%@ namespace name="CodeFluent.Model" %]
[%@ namespace name="CodeFluent.Runtime" %]
[%@ namespace name="CodeFluent.Runtime.Utilities" %]
<?xml version="1.0" ?>
<configuration>
  <configSections>
    <section name="[%=Producer.SyncfusionWPFAssemblyNamespace%]" type="CodeFluent.Runtime.CodeFluentConfigurationSectionHandler, CodeFluent.Runtime"/>
  </configSections>
  <[%=Producer.SyncfusionWPFAssemblyNamespace%] bitsServerUrl="http://localhost:1027/{0}/" />
  <system.serviceModel>
		<client>
		[%foreach (Entity entity in Producer.Project.Entities){ if (!Node.IsServiceEnabled(entity.Element)) continue;%]
			<endpoint address="http://localhost:8000/[%= entity.ClrFullTypeName %]/Service" binding="wsHttpBinding" behaviorConfiguration="MyEndpointTypeBehaviors"
				bindingConfiguration="wsHttpBindingNoSecurity"
                		contract="[%= entity.ProxyServiceInterface.ClrFullTypeName %]" />
		[%if (entity.HasPublicBinaryLargeObjectProperties) {%]
			<endpoint address="http://localhost:8000/[%= entity.ClrFullTypeName %]/BinaryService" binding="customBinding" behaviorConfiguration="MyEndpointTypeBehaviors"
				bindingConfiguration="wsHttpStreamingBinding"
                		contract="CodeFluent.Runtime.BinaryServices.ICodeFluentBinaryService"
                		name="[%= entity.ClrFullTypeName %]/BinaryService"/>
		[% }%][% }%]
		</client>
		<bindings>
			<wsHttpBinding>
				<binding name="wsHttpBindingNoSecurity" maxBufferPoolSize="2000000" maxReceivedMessageSize="2000000000">
					<security mode="None" />
				</binding>
			</wsHttpBinding>
			<customBinding>
				<binding name="wsHttpStreamingBinding">
					<httpTransport transferMode="Streamed" maxReceivedMessageSize="2147483647" />
				</binding>
			</customBinding>
		</bindings>
		<behaviors>
			<endpointBehaviors>
				<behavior name="MyEndpointTypeBehaviors" />
			</endpointBehaviors>
		</behaviors>
	</system.serviceModel>
</configuration>