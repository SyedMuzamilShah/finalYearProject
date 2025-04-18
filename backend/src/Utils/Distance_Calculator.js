export const getDistanceInMeters = (
    taskSavedLat,        // Latitude from the task's stored location
    taskSavedLng,        // Longitude from the task's stored location
    currentLatFromUser,  // Latitude from the user's current location
    currentLngFromUser   // Longitude from the user's current location
) => {
    const R = 6378000; // Radius of Earth in meters
    const toRad = (val) => (val * Math.PI) / 180;
  
    const dLat = toRad(currentLatFromUser - taskSavedLat);
    const dLng = toRad(currentLngFromUser - taskSavedLng);
  
    const a = Math.sin(dLat / 2) ** 2 +
              Math.cos(toRad(taskSavedLat)) * Math.cos(toRad(currentLatFromUser)) *
              Math.sin(dLng / 2) ** 2;
  
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
};
