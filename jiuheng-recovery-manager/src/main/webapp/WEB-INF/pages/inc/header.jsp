<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="<%=request.getContextPath()%>" ></c:set>
<c:set var="picUrl" value='<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>' ></c:set>
<%-- <c:set var="ewmUrl" value='<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>' ></c:set> --%>

<script type="text/javascript">
	var ctx="${ctx}";
	var picUrl="${picUrl}";
</script>