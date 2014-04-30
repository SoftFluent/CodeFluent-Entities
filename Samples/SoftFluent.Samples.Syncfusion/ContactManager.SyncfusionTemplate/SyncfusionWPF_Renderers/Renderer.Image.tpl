[%@ template inherits="CodeFluent.Producers.UI.BaseTemplate" %]
<syncfusion:GridDataVisibleColumn HeaderText="[%=Source.Name%]" MappingName="[%=Source.Name%]" >
  <syncfusion:GridDataVisibleColumn.CellItemTemplate>
    <DataTemplate>
      <Image Source="{Binding Path=Record.Data.[%=Source.Name%] ,Converter={StaticResource imgConverter}}"/>
    </DataTemplate>
  </syncfusion:GridDataVisibleColumn.CellItemTemplate>
  <syncfusion:GridDataVisibleColumn.HeaderStyle>
    <syncfusion:GridDataColumnStyle HorizontalAlignment="Center" />
  </syncfusion:GridDataVisibleColumn.HeaderStyle>
</syncfusion:GridDataVisibleColumn>