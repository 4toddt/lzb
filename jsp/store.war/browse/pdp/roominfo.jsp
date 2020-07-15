<dsp:page>
<dsp:getvalueof var="willFitMyRoom" param="willFitMyRoom" />
<dsp:getvalueof var="roomPlanner" param="roomPlanner" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/com/lzb/droplet/LZBNPCURLDroplet" />


<%-- 				<c:if test ="${not empty willFitMyRoom && willFitMyRoom eq 'true'}">
						<div class="will-it-fit-link">
							<img src="/img/icon-ruler.png" alt="Will it fit in my room?" />
							<dsp:droplet name="LZBNPCURLDroplet">
								<dsp:param name="catPageIdPageId" value="${storeConfig.roomMesurement}" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="roomMesurementURL" param="npcurl"/>		
								</dsp:oparam>
							</dsp:droplet>
							<a href="${contextPath}${roomMesurementURL}"><fmt:message key="pdp.willFitMyRoom"/></a>
						</div>
					</c:if>					 --%>
					<c:if test ="${not empty roomPlanner && roomPlanner eq 'true'}">
						<div class="room-planner-link">
							<img src="/img/icon-drafting-tool.png" alt="Room Planner" />
							<dsp:droplet name="LZBNPCURLDroplet">
								<dsp:param name="catPageIdPageId" value="${storeConfig.roomPlanner}" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="roomPlannerurl" param="npcurl"/>		
								</dsp:oparam>
							</dsp:droplet>
							<a href="${contextPath}${roomPlannerurl}"><fmt:message key="pdp.room.planner"/></a>
						</div>
					</c:if>
</dsp:page>