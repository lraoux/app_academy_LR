# Healthbook

[Heroku link][heroku]

[heroku]: https://damp-hollows-7371.herokuapp.com/

## Minimum Viable Product

Healthbook is a web application inspired by Facebook built using Ruby on Rails and React.js. Healthbook allows users to:

<!-- This is a Markdown checklist. Use it to keep track of your progress! -->

- [ ] Create an account
- [ ] Log in / Log out
- [ ] View a newsfeed of content
- [ ] Create, read, edit, and delete a medical profile as a patient
- [ ] Search for certain keywords

## Design Docs
* [View Wireframes][view]
* [DB schema][schema]

[view]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: User Authentication, User Model, JSON API (2 days)

In Phase 1, I will begin by implementing user signup and authentication (using
BCrypt). There will be a basic landing page after signup that will contain the
container for the application's root React component, which will be the newsfeed. Before building out the front end, I will begin by setting up a full JSON API for the medical profile.

[Details][phase-one]

### Phase 2: Flux Architecture and Medical Profile CRUD (2 days)

Phase 2 is focused on setting up Flux, the React Router, and the React view
structure for the main application. After the basic Flux architecture has been
set up, a Medical Profile store will be implemented and a set of actions corresponding to the needed CRUD functionality created. Once this is done, I will create React views for the Medical Profile. At the end of Phase 2, Medical Profiles can be created, read, edited and destroyed in the browser.

[Details][phase-two]

### Phase 3: Newsfeed and Search (2 days)

Phase 3 adds Newsfeed to the application. I will create a Newsfeed store, along with a React view and the rest of the Flux architecture. Once this is implemented, I will work on the search feature, which will allow users to search through the newsfeed or the medical profile.

[Details][phase-three]

### Phase 4: Allow Complex Styling (1 day)

I will work on styling all the components.

[Details][phase-four]

### Phase 5: Styling, Cleanup and Seeding (2 days)

Basic CSS will have been used to keep things organized up until now, but in
Phase 5 I will add some more styling, do code cleanup, and seed the database for the test account.

[Details][phase-five]

### Phase 6: Bonus (1 day)

 Phase 6 introduces the bonus features with chat as the first priority and the UI as the second priority. Time permitting, I will try the other features listed below as well.

### Bonus Features (TBD)
- [ ] Prettify UI
- [ ] Create, read, edit, destroy as a doctor
- [ ] Invite doctors to be able to view and comment on their profile
- [ ] Chat with doctors via instant messaging
- [ ] Upload photos and videos
- [ ] Rate doctors

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md
