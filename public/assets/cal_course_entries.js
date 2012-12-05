RP = {
  setup: function() {
    $('#cal_course_school_type').change(RP.filter);
    RP.filter();
    //$('#entries_table tbody tr').each(function() { $(this).find('td:nth-child(2)').hide(); $(this).find('td:nth-child(2)').hide();});
  },

  filter: function() {
    if ($('#entries_table')) {
      $('#entries_table tbody tr:not(:first-child)').each(RP.filter_single_entry);
    }
  },

  filter_single_entry: function(params) {
    var type = $('#cal_course_school_type').val();
    if ( type == "All" || type == $(this).find('td:nth-child(2)').text() ) {
      $(this).show();
    } else {
      $(this).hide();
    };
  }
}
$(RP.setup);
