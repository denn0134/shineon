<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="3.5">
  <PropertyGroup>
    <ProjectGuid>{78329CFC-D7AA-468C-8DF7-DBC4C14D671C}</ProjectGuid>
    <RootNamespace>NUnit.ShineOn.RTL</RootNamespace>
    <OutputType>Library</OutputType>
    <AssemblyName>Nunit.ShineOn.RTL</AssemblyName>
    <AllowGlobals>False</AllowGlobals>
    <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
    <TargetFrameworkVersion>v2.0</TargetFrameworkVersion>
    <RunPostBuildEvent>OnBuildSuccess</RunPostBuildEvent>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
    <DefineConstants>DEBUG;TRACE;</DefineConstants>
    <OutputPath>..\..\bin\</OutputPath>
    <GeneratePDB>True</GeneratePDB>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
    <OutputPath>..\bin</OutputPath>
    <EnableAsserts>False</EnableAsserts>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="mscorlib" />
    <Reference Include="nunit.framework">
      <HintPath>C:\Program Files %28x86%29\NUnit 2.5.2\bin\net-2.0\framework\nunit.framework.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <ProjectReference Include="..\ShineOn.RTL\ShineOn.RTL.oxygene">
      <Project>{EADE7853-FDBE-4770-B0B2-5FF5FDD2DBF7}</Project>
      <HintPath>$(Project)\..\bin\ShineOn.Rtl.dll</HintPath>
      <Name>ShineOn.RTL</Name>
    </ProjectReference>
    <Reference Include="System" />
    <Reference Include="System.Core">
      <HintPath>$(ProgramFiles)\Reference Assemblies\Microsoft\Framework\v3.5\System.Core.dll</HintPath>
    </Reference>
    <Reference Include="System.Data" />
    <Reference Include="System.Drawing" />
    <Reference Include="System.Windows.Forms" />
    <Reference Include="System.Xml" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="AssemblyInfo.pas" />
    <Compile Include="Dataset1.Designer.pas">
      <Subtype>Component</Subtype>
      <DesignableClassName>NUnit.ShineOn.RTL.Dataset1</DesignableClassName>
    </Compile>
    <Compile Include="TestCDS.pas" />
    <Compile Include="TestClasses.pas" />
    <Compile Include="TestContnrs.pas" />
    <Compile Include="TestDelphiString.pas" />
    <Compile Include="TestFileStream.pas" />
    <Compile Include="TestIniFiles.pas" />
    <Compile Include="TestStringRead.pas" />
    <Compile Include="TestStringWrite.pas" />
    <Compile Include="TestStrUtils.pas" />
    <Compile Include="TestSystem.pas" />
    <Compile Include="TestSysUtils.pas" />
    <Compile Include="TestTDateTime.pas" />
    <Compile Include="TestVariants.pas" />
  </ItemGroup>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Oxygene\RemObjects.Oxygene.targets" />
</Project>