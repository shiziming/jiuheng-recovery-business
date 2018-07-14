var jobPower={};
jobPower.initExportExcel=function(){
	var gwdmId=$('#gwdmid').val();
	var gwmcId =$('#gwmcid').val();
	var xtcxidId =$('#xtcxidid').val();
	var xtcxmcId =$('#xtcxmcid').val();
	window.location.href="power/initExportExcel?gwdmId="+encodeURI(gwdmId)+"&gwmcId="+encodeURI(gwmcId)+"&xtcxidId="+encodeURI(xtcxidId)+"&xtcxmcId="+encodeURI(xtcxmcId);
}
jobPower.downloadTemplate=function(){
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("岗位权限模板");
}
jobPower.downloadPowerTemplate=function(){
	window.location.href="power/downloadPowerTemplate";
}