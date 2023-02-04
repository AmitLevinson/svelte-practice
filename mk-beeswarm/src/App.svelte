<script>
  import data from '$data/data.js'
  console.log(data)

  console.log(data.map(d => {

      d['test'] = d['ועדות'],
      d['duration'] = calcHours(d['שעות'])
    }));

function calcHours (duration) {
  let hours, min
  [hours, min] = duration.split(":");
  
  return parseInt(hours) + (parseInt(min) / 60);
}

</script>