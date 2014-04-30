[%@ namespace name="System" %]
[%@ namespace name="CodeFluent.Model" %]
[%@ namespace name="CodeFluent.Runtime" %]
[%@ namespace name="CodeFluent.Runtime.UI" %]
[%@ namespace name="CodeFluent.Runtime.Utilities" %]
[%@ namespace name="CodeFluent.Producers.UI" %]

[%@ template
enumerable="Producer.Project.Entities"
enumerableItemName="entity"
enumerableTargetPathFunc='Path.Combine(Path.GetDirectoryName(TargetPath), entity.Name) + "View.xaml"'
inherits="CodeFluent.Producers.UI.BaseTemplate" %]
	<UserControl x:Class="[%=Producer.SyncfusionWPFAssemblyNamespace%].Controls.[%=entity.Name%]View"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	xmlns:syncfusion="http://schemas.syncfusion.com/wpf"
	xmlns:i="http://schemas.microsoft.com/expression/2010/interactivity"
	xmlns:behavior="clr-namespace:[%=Producer.SyncfusionWPFAssemblyNamespace%].Behaviors"
    xmlns:cftools="clr-namespace:[%=Producer.SyncfusionWPFAssemblyNamespace%].Runtime">
	<Control.Resources>
		[%if (entity.HasPublicBinaryLargeObjectProperties)
		{%]
		<cftools:BinaryImageConverter x:Key="imgConverter" />
		[%}%]
	</Control.Resources>
	<Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        
        <Button Grid.Row="0" Margin="10" VerticalAlignment="Top" HorizontalAlignment="Right" RenderTransformOrigin="0.5, 0.5"
                Width="48" Height="48" Style="{StaticResource ButtonStyle}" >
            <i:Interaction.Behaviors>
                <behavior:RestoreBehavior />
            </i:Interaction.Behaviors>
            <Grid Background="Transparent">
                <Image Source="/Resources/Arrow Left.png"/>
            </Grid>
        </Button>
        <syncfusion:GridDataControl x:Name="GridFusion"
                                        AllowEdit="False"
                                        AutoPopulateColumns="False"
                                        AutoPopulateRelations="False"
                                        ColumnSizer="Star"
                                        IsSynchronizedWithCurrentItem="True"
                                        NotifyPropertyChanges="True"
                                        ShowAddNewRow="False"
                                        ShowGroupDropArea="True"
                                        UpdateMode="PropertyChanged"
					                    PersistGroupsExpandState="True"
                                        VisualStyle="Metro"
                                        Grid.Row="1">

            <syncfusion:GridDataControl.VisibleColumns>

				[% foreach (ViewProperty vProp in entity.DefaultView.Properties) {
					if (vProp.UIEnabled)
					{						
						//TypedObject obj = new TypedObject(Culture, vProp);
						//Producer.WriteControlRenderer(Writer, Context, obj, RendererType.Column);
Write(vProp, null, RendererTemplateSearchModes.None, RendererType.Read);
					}
				}%]

            </syncfusion:GridDataControl.VisibleColumns>
        </syncfusion:GridDataControl>
    </Grid>
</UserControl>	