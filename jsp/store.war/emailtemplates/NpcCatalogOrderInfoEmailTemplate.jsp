<dsp:page>
<dsp:getvalueof param="USCount" var="USCount"/>
<dsp:getvalueof param="CanadaCount"var="canadaCount"/>
<dsp:getvalueof param="currentDate" var="currentDate"/>
<dsp:getvalueof param="previousWeekDate" var="prviousWeekDate"/>
<dsp:getvalueof param="totalBrochureCount" var="totalBrochureCount"/>

ARCHWAY EXPORT REPORT FOR <dsp:valueof value="${prviousWeekDate}"/> TO <dsp:valueof value="${currentDate}"/>
<br/>
USA Count : ${USCount}<br/>
CANADA Count : ${canadaCount}<br/>
<hr><br/>
Total Product Brochure Count : ${totalBrochureCount}<br/>
<hr><br/>

</dsp:page>