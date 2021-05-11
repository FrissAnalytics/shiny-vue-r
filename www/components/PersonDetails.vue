<template>
  <v-card flat tile color="black" class="pa-8 white--text person-card">
    <div v-if="person">
      <v-row>
        <v-col cols="3">
          <div class="person-details-left">
            <img
              :src="`https://www.themoviedb.org/t/p/w600_and_h900_bestv2${person.profile_path}`"
              class="person-img rounded-lg"
            />
          </div>

          <div class="d-flex person-details">
            <div class="text-capitalize">
              <p>birthday</p>
              <p>known for</p>
              <p>place of birth</p>
            </div>

            <div class="text-capitalize px-4">
              <p>{{ person.birthday }}</p>
              <p>{{ person.known_for_department }}</p>
              <p>{{ person.place_of_birth }}</p>
            </div>
          </div>
        </v-col>

        <v-col cols="9">
          <p class="text-h2 font-weight-black">{{ person.name }}</p>

          <p class="">{{ person.biography }}</p>
        </v-col>
      </v-row>
    </div>
  </v-card>
</template>

<script>
module.exports = {
  name: "person-detail",

  computed: {
    person() {
      console.log("person details", this.$store.state.personDetails);
      return this.$store.state.personDetails;
    },
  },
};
</script>

<style scoped>
.person-card {
  margin-top: 48px;
  height: calc(100vh - 48px);

  color: white;
}

.person-img {
  height: 70vh;
}
</style>