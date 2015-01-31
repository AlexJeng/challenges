<r:require modules='datepicker'/>
<g:javascript>
  $(document).ready(function() {
    $(".datepicker").datepicker({ dateFormat: "${grailsApplication.config.datePatternPicker}" });
  })
</g:javascript>
