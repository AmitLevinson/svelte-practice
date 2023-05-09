export function calcHours (duration) {
    let hours, min
    [hours, min] = duration.split(":")
    
    return (parseInt(hours) + (parseInt(min) / 60));
  }