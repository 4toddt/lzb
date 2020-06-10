<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
<div class="design-border">
	<div class="design-message ">Click on the launch room planner button below to enter your room's dimensions, then drag-and-drop furniture to see
what fits best.<div>
			<a href="${contextPath }/content/DesignInspirations/3DRoomPlanner/" class="btn-primary">launch room planner</a>
		</div>
	</div>
</div>



