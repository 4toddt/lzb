<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
  <h2> Feed status email</h2></br>
  <h3> File Name : </h3> &nbsp;&nbsp;<dsp:valueof param="fileName"/>
  </br></br>
  <h4><dsp:valueof param="feedMessage"></dsp:valueof></h4>
  <dsp:droplet name="/atg/dynamo/droplet/ForEach">
  <dsp:param name="array" param="failedList"/>
    <dsp:oparam name="output">
      <dsp:valueof param="element"/>,
    </dsp:oparam>
  </dsp:droplet>
</dsp:page>