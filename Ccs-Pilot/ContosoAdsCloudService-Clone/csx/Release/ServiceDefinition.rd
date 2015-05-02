<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="ContosoAdsCloudService_Clone" generation="1" functional="0" release="0" Id="4c1e6663-a16c-4a91-a327-242ef05aa733" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="ContosoAdsCloudService_CloneGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="ContosoAdsWeb:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/LB:ContosoAdsWeb:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="ContosoAdsWeb:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/MapContosoAdsWeb:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="ContosoAdsWebInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/MapContosoAdsWebInstances" />
          </maps>
        </aCS>
        <aCS name="ContosoAdsWorker:ConstosoAdsDbConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/MapContosoAdsWorker:ConstosoAdsDbConnectionString" />
          </maps>
        </aCS>
        <aCS name="ContosoAdsWorker:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/MapContosoAdsWorker:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="ContosoAdsWorkerInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/MapContosoAdsWorkerInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:ContosoAdsWeb:Endpoint1">
          <toPorts>
            <inPortMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWeb/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapContosoAdsWeb:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWeb/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapContosoAdsWebInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWebInstances" />
          </setting>
        </map>
        <map name="MapContosoAdsWorker:ConstosoAdsDbConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWorker/ConstosoAdsDbConnectionString" />
          </setting>
        </map>
        <map name="MapContosoAdsWorker:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWorker/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapContosoAdsWorkerInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWorkerInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="ContosoAdsWeb" generation="1" functional="0" release="0" software="C:\Users\Tang\documents\visual studio 2013\Projects\ContosoAdsCloudService-Clone\ContosoAdsCloudService-Clone\csx\Release\roles\ContosoAdsWeb" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;ContosoAdsWeb&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;ContosoAdsWeb&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;ContosoAdsWorker&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWebInstances" />
            <sCSPolicyUpdateDomainMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWebUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWebFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="ContosoAdsWorker" generation="1" functional="0" release="0" software="C:\Users\Tang\documents\visual studio 2013\Projects\ContosoAdsCloudService-Clone\ContosoAdsCloudService-Clone\csx\Release\roles\ContosoAdsWorker" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="ConstosoAdsDbConnectionString" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;ContosoAdsWorker&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;ContosoAdsWeb&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;ContosoAdsWorker&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWorkerInstances" />
            <sCSPolicyUpdateDomainMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWorkerUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWorkerFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="ContosoAdsWebUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="ContosoAdsWorkerUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="ContosoAdsWebFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="ContosoAdsWorkerFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="ContosoAdsWebInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="ContosoAdsWorkerInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="5cd71167-33d6-4bfd-928a-e516d790d412" ref="Microsoft.RedDog.Contract\ServiceContract\ContosoAdsCloudService_CloneContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="8faf35ef-2c39-4444-9ac9-9df4b4b69181" ref="Microsoft.RedDog.Contract\Interface\ContosoAdsWeb:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/ContosoAdsCloudService_Clone/ContosoAdsCloudService_CloneGroup/ContosoAdsWeb:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>