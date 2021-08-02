extends Node

# Signal emitted when the player places an entity, passing the entity and its
# position in map coordinates
signal entity_placed(entity, cellv)

# Signal emitted when the player removes an entity, passing the entity and its
# position in map coordinates
signal entity_removed(entity, cellv)

# Signal emmited when the simulation triggers the systems for updates
signal systems_ticked(delta)
