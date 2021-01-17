extends Node

# Signal emitted when the player places an entity, passing the entity and its
# position in map coordinates
signal entity_placed(entity, cellv)

# Signal emitted when the player removes an entity, passing the entity and its
# position in map coordinates
signal entity_removed(entity, cellv)
